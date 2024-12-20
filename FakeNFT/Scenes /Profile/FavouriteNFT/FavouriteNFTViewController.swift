//
//  FavouriteNFTViewController.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 16.12.2024.
//

import UIKit
import SkeletonView

// MARK: - FavouriteNFTViewController

final class FavouriteNFTViewController: UIViewController {

    // MARK: - Private properties

    private enum Constants {
        enum CollectionView {
            static let itemSize = CGSize(width: 168, height: 80)
            static let interitemSpacing: CGFloat = 7
            static let sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
            static let lineSpacing: CGFloat = 20
        }
    }
    private let favouriteNFTView = FavouriteNFTView()
    private var viewModel: FavouriteNFTViewModelProtocol

    // MARK: - Initializers

    init(viewModel: FavouriteNFTViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods

    override func loadView() {
        view = favouriteNFTView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        bind()
        viewModel.viewDidLoad()
        favouriteNFTView.collectionView.dataSource = self
        favouriteNFTView.collectionView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeSkeletonState(isShown: true)
    }

    // MARK: - Private methods

    private func bind() {
        viewModel.onNFTListLoaded = { [weak self] in
            DispatchQueue.main.async {
                guard let self else { return }
                self.setNeededState()
                self.changeSkeletonState(isShown: false)
                self.favouriteNFTView.collectionView.reloadData()
            }
        }
        viewModel.onNFTListLoadError = { [weak self] error in
            DispatchQueue.main.async {
                guard let self else { return }
                AlertPresenter.show(in: self, model: AlertModelPlusProfile.favouriteNFTLoadError(message: error))
            }
        }
    }

    private func changeSkeletonState(isShown: Bool) {
        let collectionView = favouriteNFTView.collectionView
        if isShown {
            guard viewModel.nftList == nil else { return }
            collectionView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
        } else {
            collectionView.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }

    private func setNeededState() {
        if let nftList = viewModel.nftList, nftList.isEmpty {
            favouriteNFTView.changeState(.empty)
        } else {
            favouriteNFTView.changeState(.standart)
        }
    }

    private func configureNavigationBar() {
        let leftButton = UIBarButtonItem(
            image: A.Icons.back.image,
            style: .plain,
            target: self,
            action: #selector(back)
        )
        navigationItem.setLeftBarButton(leftButton, animated: false)
        navigationItem.title = L.Profile.FavouriteNFT.title
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UICollectionViewDataSource

extension FavouriteNFTViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        FavouriteNFTCollectionViewCell.defaultReuseIdentifier
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.nftList?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: FavouriteNFTCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        if let nftList = viewModel.nftList {
            cell.delegate = self
            cell.configCell(model: nftList[indexPath.row])
        }
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavouriteNFTViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        Constants.CollectionView.itemSize
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.CollectionView.interitemSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Constants.CollectionView.sectionInset
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt: Int
    ) -> CGFloat {
        Constants.CollectionView.lineSpacing
    }

}

// MARK: - FavouriteNFTCollectionViewCellDelegate

extension FavouriteNFTViewController: FavouriteNFTCollectionViewCellDelegate {

    func didTapOnLikeButton(_ cell: FavouriteNFTCollectionViewCell) {
        guard let id = cell.id else { return }
        cell.changeLikeButtonState(isEnabled: false)
        viewModel.unlikeNFT(with: id) { [weak self] result in
            switch result {
            case .success: break
            case .failure(let error):
                DispatchQueue.main.async {
                    guard let self else { return }
                    AlertPresenter.show(
                        in: self,
                        model: AlertModelPlusProfile.unlikeError(message: error.localizedDescription)
                    )
                    cell.changeLikeButtonState(isEnabled: true)
                }
            }
        }
    }

}
