//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation
import SkeletonView

final class PaymentViewController: UIViewController {
    // MARK: - Private properties
    
    private let currencyView = PaymentView()
    private var viewModel = PaymentViewModel()
    private var selectedIndexPath: IndexPath?
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden methods
    
    override func loadView() {
        view = currencyView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bind()
        currencyView.colletionView.dataSource = self
        currencyView.payTableView.dataSource = self
        currencyView.colletionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showSkeletonIfNeeded()
    }
    
    // MARK: - Private methods
    
    private func bind() {
        viewModel.onCurrencyListLoaded = { [weak self] in
            DispatchQueue.main.async {
                guard let self else { return }
                self.currencyView.colletionView.reloadData()
                self.currencyView.payTableView.reloadData()
            }
        }
        viewModel.onCurrencyListLoadError = { [weak self] error in
            DispatchQueue.main.async {
                guard self != nil else { return }
            }
        }
        viewModel.onPaymentSuccess = { [weak self] in
            DispatchQueue.main.async {
                guard let navigationController = self?.navigationController else {
                    print("NavigationController is not available.")
                    return
                }
                
                let successfulPaymentVC = SuccessfulPaymentViewController()
                successfulPaymentVC.hidesBottomBarWhenPushed = true
                let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationController.navigationBar.topItem?.backBarButtonItem = backButton
                navigationController.navigationBar.isHidden = true
                
                navigationController.pushViewController(successfulPaymentVC, animated: true)
            }
        }
        
        viewModel.onPaymentError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showPaymentErrorAlert()
            }
        }
    }
    
    private func showPaymentErrorAlert(message: String) {
        let alert = UIAlertController(title: "Payment Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showSkeletonIfNeeded() {
        if viewModel.currenciesList == nil {
            currencyView.colletionView.visibleCells.forEach {
                $0.showAnimatedSkeleton(transition: .crossDissolve(0.25))
            }
            currencyView.payTableView.visibleCells.forEach {
                $0.showAnimatedSkeleton(transition: .crossDissolve(0.25))
            }
        }
    }
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension PaymentViewController: SkeletonCollectionViewDataSource, UITableViewDataSource, UICollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        switch skeletonView {
        case currencyView.colletionView:
            return PaymentCollectionViewCell.defaultReuseIdentifier
        case currencyView.payTableView:
            return PaymentBottomTableViewCell.defaultReuseIdentifier
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case currencyView.payTableView:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case currencyView.payTableView:
            let cell: PaymentBottomTableViewCell = tableView.dequeueReusableCell()
            if let currenciesList = viewModel.currenciesList {
                cell.hideSkeleton(transition: .crossDissolve(0.25))
                cell.configCell()
                cell.delegate = self
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case currencyView.colletionView:
            return viewModel.currenciesList?.count ?? 4
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case currencyView.colletionView:
            let cell: PaymentCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            if let currenciesList = viewModel.currenciesList {
                cell.hideSkeleton(transition: .crossDissolve(0.25))
                let currency = currenciesList[indexPath.row]
                cell.configCell(with: currency)
                cell.setSelected(indexPath == selectedIndexPath)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension PaymentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        var indexPathsToReload = [indexPath]
        if let previousIndexPath {
            indexPathsToReload.append(previousIndexPath)
        }
        collectionView.reloadItems(at: indexPathsToReload)
    }
}

extension PaymentViewController: PaymentTableViewCellDelegate {
    func didTapPayButton() {
        guard let selectedCurrency = viewModel.currenciesList?[selectedIndexPath?.row ?? 0] else {
            return
        }
        let currencyId = selectedCurrency.id
        viewModel.initiatePayment(for: currencyId)
    }
}


extension PaymentViewController {
    private func showPaymentErrorAlert() {
        let alertModel = AlertModel.paymentFailedAlert(
            retryCompletion: { [weak self] in
                if let currencyId = self?.getSelectedCurrencyId() {
                    self?.viewModel.initiatePayment(for: currencyId)
                }
            },
            cancelCompletion: {
            }
        )
        AlertPresenter.show(in: self, model: alertModel)
    }
    
    private func getSelectedCurrencyId() -> String? {
        guard let selectedCurrency = viewModel.currenciesList?[selectedIndexPath?.row ?? 0] else {
            return nil
        }
        return selectedCurrency.id
    }
    
}


