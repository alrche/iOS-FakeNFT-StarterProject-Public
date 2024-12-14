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
        viewModel.viewDidLoad()
        configureNavigationBar()
        configureView()
        bind()
    }

    // MARK: - Private methods
    private func bind() {
        viewModel.onProfileInfoChanged = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.profileView.updateUI()
                self.profileView.changeSkeletonState(isShown: false)
                self.editButton?.isEnabled = true
            }
        }
        viewModel.onFetchError = { [weak self] error in
            guard let self else { return }
            DispatchQueue.main.async {
                AlertPresenter.show(in: self, model: .profileFetchError(message: error) {
                    self.viewModel.fetchProfile()
                })
            }
        }
        viewModel.onEditError = { [weak self] error in
            guard let self else { return }
            DispatchQueue.main.async {
                AlertPresenter.show(in: self, model: .profileEditError(message: error) {
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
        navBar.topItem?.setRightBarButton(rightButton, animated: false)
        navBar.tintColor = A.Colors.blackDynamic.color
    }

    private func configureView() {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(presentWebViewController)
        )
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
