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
    private var selectedNFT: CartNFTModel?
    private let cartView = CartView()
    private var viewModel = CartViewModel()
    private lazy var sortButton = UIBarButtonItem(
        image: A.Icons.sort.image,
        style: .plain,
        target: self,
        action: #selector(didTapSortButton)
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
                
                self.updateEmptyViewVisibility()
            }
        }
        viewModel.onNFTListLoadError = { [weak self] error in
            DispatchQueue.main.async {
                guard self != nil else { return }
                
            }
        }
    }
    
    @objc private func didTapSortButton() {
        let sortAlert = AlertModel.sortActionSheet(
            priceCompletion: { [weak self] in
                self?.viewModel.sortByPrice()
            },
            ratingCompletion: { [weak self] in
                self?.viewModel.sortByRating()
            },
            nameCompletion: { [weak self] in
                self?.viewModel.sortByName()
            }
        )
        AlertPresenter.show(in: self, model: sortAlert)
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
    
    private func updateEmptyViewVisibility() {
        if let nftList = viewModel.nftList, nftList.isEmpty {
            self.navigationController?.isNavigationBarHidden = true
            self.cartView.emptyView.isHidden = false
            self.cartView.tableView.isHidden = true
            self.cartView.payTableView.isHidden = true
        } else {
            self.navigationController?.isNavigationBarHidden = false
            self.cartView.emptyView.isHidden = true
            self.cartView.tableView.isHidden = false
            self.cartView.payTableView.isHidden = false
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
                cell.delegate = self
            }
            return cell
        case cartView.payTableView:
            let cell: CartPayTableViewCell = tableView.dequeueReusableCell()
            if let nftList = viewModel.nftList {
                cell.hideSkeleton(transition: .crossDissolve(0.25))
                cell.configCell(model: nftList)
                cell.delegate = self
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension CartViewController: CartPayTableViewCellDelegate {
    func didTapPayButton() {
        navigateToPaymentScreen()
    }
    
    func navigateToPaymentScreen() {
        guard let navigationController = navigationController else {
            print("NavigationController is not available.")
            return
        }
        let paymentViewController = PaymentViewController()
        paymentViewController.title = L.Cart.choosePay
        paymentViewController.hidesBottomBarWhenPushed = true
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        navigationItem.backBarButtonItem?.tintColor = A.Colors.blackDynamic.color
        
        navigationController.pushViewController(paymentViewController, animated: true)
    }
    
}

extension CartViewController: CartTableViewCellDelegate {
    func didTapDeleteButton(on cell: CartTableViewCell) {
        guard let indexPath = cartView.tableView.indexPath(for: cell),
              let nftList = viewModel.nftList else { return }
        selectedNFT = nftList[indexPath.row]
        showConfirmationPopup()
    }
    private func showConfirmationPopup() {
        let confirmationPopup = ConfirmationPopupView(frame: UIScreen.main.bounds)
        
        if let selectedNFT = selectedNFT {
            confirmationPopup.configCell(model: selectedNFT)
        }
        confirmationPopup.onDelete = { [weak self, weak confirmationPopup] in
            guard let self = self, let confirmationPopup = confirmationPopup else { return }
            if var nftList = self.viewModel.nftList {
                if let index = nftList.firstIndex(where: { $0.name == self.selectedNFT?.name }) {
                    nftList.remove(at: index)
                    self.viewModel.updateNFTList(nftList)
                    self.cartView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                }
                self.updateEmptyViewVisibility()
            }
        }
        
        confirmationPopup.onCancel = {
            [weak confirmationPopup] in
            guard let confirmationPopup = confirmationPopup else { return }
        }
        
        UIApplication.shared.keyWindow?.addSubview(confirmationPopup)
    }
}


