//
//  EditProfileViewController.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit

// MARK: - EditProfileViewController
final class EditProfileViewController: UIViewController {

    // MARK: - Private properties
    private let editProfileView: EditProfileView
    private let viewModel: ProfileViewModel

    private var isProfileEdited: Bool {
        let oldProfileModel = EditProfileModel(
            name: viewModel.model?.name ?? "",
            avatar: viewModel.model?.avatar ?? "",
            description: viewModel.model?.description ?? "",
            website: viewModel.model?.website ?? ""
        )
        let newProfileModel = editProfileView.editProfileModel
        return oldProfileModel != newProfileModel
    }

    // MARK: - Initializers
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        self.editProfileView = EditProfileView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        presentationController?.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureView()
    }

    // MARK: - Private methods
    private func configureView() {
        editProfileView.closeButton.addTarget(
            self,
            action: #selector(onCloseButtonTap),
            for: .touchUpInside
        )
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(changePhoto(_:))
        )
        editProfileView.changeAvatarView.addGestureRecognizer(gestureRecognizer)
    }

    private func showConfirmationAlert() {
        AlertPresenter.show(in: self, model: .confirmChanging(
            agreeCompletion: { [weak self] in
                guard let self else { return }
                self.viewModel.editProfile(editProfileModel: self.editProfileView.editProfileModel)
                self.dismiss(animated: true)
            },
            cancelCompletion: { [weak self] in
                self?.dismiss(animated: true)
            })
        )
    }

    private func closeAction() {
        if isProfileEdited {
            showConfirmationAlert()
        } else {
            dismiss(animated: true)
        }
    }

    @objc private func onCloseButtonTap() {
        closeAction()
    }

    @objc private func changePhoto(_ sender: UITapGestureRecognizer) {
        AlertPresenter.show(in: self, model: .changePhotoAlert { [weak editProfileView] avatar in
            editProfileView?.avatar = avatar
            editProfileView?.hideChangeAvatarView()
        })
    }

}

// MARK: - UIAdaptivePresentationControllerDelegate
extension EditProfileViewController: UIAdaptivePresentationControllerDelegate {

    func presentationControllerShouldDismiss(
        _ presentationController: UIPresentationController
    ) -> Bool {
        !isProfileEdited
    }

    public func presentationControllerDidAttemptToDismiss(
        _ presentationController: UIPresentationController
    ) {
        closeAction()
    }

}
