//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import UIKit
import ProgressHUD

final class CatalogViewController: UIViewController {
    private let viewModel: CatalogViewModelProtocol
    private let servicesAssembly: ServicesAssembly
    
    private lazy var NFTTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: CatalogTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(servicesAssembly: ServicesAssembly, viewModel: CatalogViewModelProtocol) {
        self.servicesAssembly = servicesAssembly
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        addSubvies()
        loadData()
        setUpBinding()
    }
    
    private func setUpBinding() {
        viewModel.reloadTableView = { [weak self] in
            self?.NFTTableView.reloadData()
        }
    }
    
    private func configureNavBar() {
        let sortButton = UIBarButtonItem(
            image: A.Icons.sort.image,
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        sortButton.tintColor = A.Colors.blackDynamic.color
        navigationItem.rightBarButtonItem = sortButton
    }
    
    private func addSubvies() {
        view.addSubview(NFTTableView)
        
        NSLayoutConstraint.activate([
            NFTTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            NFTTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            NFTTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            NFTTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadData() {
        ProgressHUD.animate()
        ProgressHUD.animationType = .circleBarSpinFade
        viewModel.fetchCollections {
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                self.NFTTableView.reloadData()
            }
        }
    }
    
    @objc private func sortButtonTapped() {
        let alert = CustomAlertControllerForSort(title: L.Alert.Sort.title, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: L.Alert.close, style: .cancel, handler: nil)
        let sortByTitle = UIAlertAction(title: L.Alert.Sort.name, style: .default) { [ weak self ] _ in
            self?.viewModel.sortByName()
        }
        
        let sortByNftQuantity = UIAlertAction(title: L.Alert.Sort.amount, style: .default) { [ weak self ] _ in
            self?.viewModel.sortByCount()
        }
        
        alert.setDimmingColor(UIColor.black.withAlphaComponent(0.5))
        alert.addAction(cancelAction)
        alert.addAction(sortByTitle)
        alert.addAction(sortByNftQuantity)
        present(alert, animated: true)
    }
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ProgressHUD.animate()
        ProgressHUD.animationType  = .circleBarSpinFade
        viewModel.getProfile() {
            DispatchQueue.main.async { [self] in
                guard let profile = viewModel.profile, let order = viewModel.order else {
                    return
                }
    
                let viewModelForCollectionVC = CollectionViewModel(
                    pickedCollection: viewModel.collection(at: indexPath.row),
                    model: CollectionModel(networkClient: DefaultNetworkClient(), storage: NftStorageImpl()), profile: profile, order: order)
                
                let collectionVC = CollectionViewController(viewModel: viewModelForCollectionVC)
                self.navigationController?.pushViewController(collectionVC, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
}

extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCollections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.identifier, for: indexPath) as? CatalogTableViewCell else {
            assertionFailure("Не удалось выполнить приведение к CategoryTableViewСеll")
            return UITableViewCell()
        }
        let nft = viewModel.collection(at: indexPath.row)
        cell.prepareForReuse()
        cell.configCell(name: nft.name, count: nft.nfts.count, image: nft.cover)
        cell.selectionStyle = .none
        return cell
    }
}

private enum Constants {
    static let openNftTitle = L.Catalog.openNft
    static let testNftId = "7773e33c-ec15-4230-a102-92426a3a6d5a"
}
