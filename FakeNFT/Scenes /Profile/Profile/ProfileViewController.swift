//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 11.12.2024.
//

import UIKit

// MARK: - ProfileViewController

final class ProfileViewController: UIViewController {

    // MARK: - Private properties

    private enum Constants {
        enum TableView {
            static let height: CGFloat = 54
        }
    }
    private let profileView: ProfileView
    private let viewModel: ProfileViewModel
    private var editButton: UIBarButtonItem? {
        navigationItem.rightBarButtonItem
    }

    // MARK: - Initializers

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        self.profileView = ProfileView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bind()
        viewModel.fetchProfile()
    }

    // MARK: - Private methods
    
    private func bind() {
        viewModel.onProfileInfoChanged = { [weak self] in
            DispatchQueue.main.async {
                guard let self else { return }
                self.profileView.changeSkeletonState(isShown: false)
                self.editButton?.isEnabled = true
                self.profileView.updateUI()
            }
        }
        viewModel.onFetchError = { [weak self] error in
            DispatchQueue.main.async {
                guard let self else { return }
                AlertPresenter.show(in: self, model: AlertModelPlusProfile.profileFetchError(message: error) {
                    self.viewModel.fetchProfile()
                })
            }
        }
        viewModel.onEditError = { [weak self] error in
            DispatchQueue.main.async {
                guard let self else { return }
                AlertPresenter.show(in: self, model: AlertModelPlusProfile.profileEditError(message: error) {
                    self.viewModel.fetchProfile()
                })
            }
        }
    }

    private func configureNavigationBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        let rightButton = UIBarButtonItem(
            image: A.Icons.edit.image,
            style: .plain,
            target: self,
            action: #selector(presentEditProfileViewController)
        )
        navigationItem.setRightBarButton(rightButton, animated: false)
        navBar.tintColor = A.Colors.blackDynamic.color
    }

    private func configureView() {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(presentWebViewController)
        )
        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
        profileView.initialize(gestureRecognizer: gestureRecognizer)
        if viewModel.model == nil {
            profileView.changeSkeletonState(isShown: true)
            editButton?.isEnabled = false
        }
    }

    @objc private func presentEditProfileViewController() {
        let vc = EditProfileViewController(viewModel: viewModel)
        present(vc, animated: true)
    }

    @objc private func presentWebViewController() {
        guard let model = viewModel.model else { return }
        guard let url = URL(string: model.website) else {
            AlertPresenter.show(in: self, model: .urlParsingError)
            return
        }
        let viewModel = WebViewModel()
        let vc = WebViewController(webViewModel: viewModel, url: url)
        present(vc, animated: true)
    }

}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell()
        cell.configCell(label: viewModel.cells[indexPath.row].name)
        return cell
    }

}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.TableView.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = viewModel.cells[indexPath.row]
        switch cell {
        case .myNFT:
            let viewModel = MyNFTViewModel()
            let viewController = MyNFTViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        case .favouriteNFT:
            // TODO: implement FavouriteNFT
            break
        case .about:
            // TODO: implement About
            break
        }
    }

}
