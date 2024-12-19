//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//

import Foundation
import SkeletonView

final class CartViewController: UIViewController {

    // MARK: - Private properties

    private let cartView = CartView()
    private var viewModel = CartViewModel()
    private lazy var sortButton = UIBarButtonItem(
        image: A.Icons.sort.image,
        style: .plain,
        target: self,
        action: nil
    )

    // MARK: - Initializers

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods

    override func loadView() {
        view = cartView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        viewModel.viewDidLoad()
        bind()
        cartView.tableView.dataSource = self
        cartView.payTableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showSkeletonIfNeeded()
    }

    // MARK: - Private methods

    private func bind() {
        viewModel.onNFTListLoaded = { [weak self] in
            DispatchQueue.main.async {
                guard let self else { return }
               
                self.changeSortButtonState(isEnabled: true)
                self.cartView.tableView.reloadData()
                self.cartView.payTableView.reloadData()
            }
        }
        viewModel.onNFTListLoadError = { [weak self] error in
            DispatchQueue.main.async {
                guard self != nil else { return }
               
            }
        }
    }

    private func configureNavigationBar() {
        sortButton.tintColor = A.Colors.blackDynamic.color
        navigationItem.setRightBarButton(sortButton, animated: false)
    }

    private func showSkeletonIfNeeded() {
        if viewModel.nftList == nil {
            cartView.tableView.visibleCells.forEach {
                $0.showAnimatedSkeleton(transition: .crossDissolve(0.25))
            }
            cartView.payTableView.visibleCells.forEach {
                $0.showAnimatedSkeleton(transition: .crossDissolve(0.25))
            }
        }
    }

    private func changeSortButtonState(isEnabled: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITableViewDataSource

extension CartViewController: SkeletonTableViewDataSource {

    func collectionSkeletonView(
            _ skeletonView: UITableView,
            cellIdentifierForRowAt indexPath: IndexPath
        ) -> ReusableCellIdentifier {
            switch skeletonView {
            case cartView.tableView:
                return CartTableViewCell.defaultReuseIdentifier
            case cartView.payTableView:
                return CartPayTableViewCell.defaultReuseIdentifier
            default:
                return ""
            }
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch tableView {
            case cartView.tableView:
                return viewModel.nftList?.count ?? 4
            case cartView.payTableView:
                return 1
            default:
                return 0
            }
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch tableView {
            case cartView.tableView:
                let cell: CartTableViewCell = tableView.dequeueReusableCell()
                if let nftList = viewModel.nftList {
                    cell.hideSkeleton(transition: .crossDissolve(0.25))
                    cell.configCell(model: nftList[indexPath.row])
                }
                return cell
            case cartView.payTableView:
                let cell: CartPayTableViewCell = tableView.dequeueReusableCell()
                if let nftList = viewModel.nftList {
                    cell.hideSkeleton(transition: .crossDissolve(0.25))
                    cell.configCell(model: nftList)
                }
                return cell
            default:
                return UITableViewCell()
            }
        }

}
