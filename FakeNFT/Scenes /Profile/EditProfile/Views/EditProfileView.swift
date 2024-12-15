//
//  EditProfileView.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit
import Kingfisher

// MARK: - EditProfileView

final class EditProfileView: UIView {

    // MARK: - Public properties

    var editProfileModel: EditProfileModel {
        EditProfileModel(
            name: nameTextField.text ?? "",
            avatar: avatar ?? "",
            description: descriptionTextView.text ?? "",
            website: websiteTextField.text ?? ""
        )
    }

    var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(A.Icons.close.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        return button
    }()

    var avatar: String? {
        didSet {
            updateAvatar()
        }
    }

    lazy var changeAvatarView: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.background.color
        view.addSubview(changeAvatarLabel)
        view.isUserInteractionEnabled = true
        return view
    }()

    // MARK: - Private properties

    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let textFieldMaxLength: Int = 100
        static let textViewMaxLength: Int = 400
        enum ContentView {
            static let horizontalSpacing: CGFloat = 16
        }
        enum ImageView {
            static let topInset: CGFloat = 22
            static let widthAndHeight: CGFloat = 70
        }
        enum CloseButton {
            static let topInset: CGFloat = 16
            static let widthAndHeight: CGFloat = 42
        }
        enum StackView {
            static let smallInset: CGFloat = 8
            static let bigInset: CGFloat = 24
        }
        enum ScrollView {
            static let bottomContentInset: CGFloat = 20
        }
    }

    private let viewModel: ProfileViewModel
    private var model: ProfileModel? {
        viewModel.model
    }

    private var notificationCenter: NotificationCenter {
        NotificationCenter.default
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset.bottom = Constants.ScrollView.bottomContentInset
        return scrollView
    }()
    private let contentView = UIView()
    private lazy var stackView = EditProfileStackView(
        spacing: Constants.StackView.bigInset,
        arrangedSubviews: [nameStackView, descriptionStackView, websiteStackView]
    )
    private lazy var nameStackView = EditProfileStackView(
        spacing: Constants.StackView.smallInset,
        arrangedSubviews: [nameLabel, nameTextField]
    )
    private lazy var descriptionStackView = EditProfileStackView(
        spacing: Constants.StackView.smallInset,
        arrangedSubviews: [descriptionLabel, descriptionTextView]
    )
    private lazy var websiteStackView = EditProfileStackView(
        spacing: Constants.StackView.smallInset,
        arrangedSubviews: [websiteLabel, websiteTextField]
    )
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = A.Images.Profile.avatar.image
        imageView.layer.cornerRadius = Constants.ImageView.widthAndHeight / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private let changeAvatarLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .Medium.small
        label.textAlignment = .center
        label.textColor = A.Colors.white.color
        label.isUserInteractionEnabled = true
        return label
    }()
    private let nameLabel = EditProfileLabel()
    private let descriptionLabel = EditProfileLabel()
    private let websiteLabel = EditProfileLabel()
    private let nameTextField = TextField(cornerRadius: Constants.cornerRadius)
    private let websiteTextField = TextField(cornerRadius: Constants.cornerRadius)
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = A.Colors.lightGrayDynamic.color
        textView.textColor = A.Colors.blackDynamic.color
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.font = .Regular.large
        textView.layer.cornerRadius = Constants.cornerRadius
        textView.textContainerInset = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 16)
        return textView
    }()

    // MARK: - Initializers

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        nameTextField.delegate = self
        websiteTextField.delegate = self
        descriptionTextView.delegate = self
        setupUI()
        setupLayout()
        registerKeyboardObserver()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeKeyboardObserver()
    }

    // MARK: - Public methods

    func hideChangeAvatarView() {
        self.changeAvatarView.isHidden = true
        self.imageView.isUserInteractionEnabled = false
    }

    // MARK: - Layout

    private var scrollViewConstraints: [NSLayoutConstraint] {
        [
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Constants.ContentView.horizontalSpacing
            ),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.ContentView.horizontalSpacing
            ),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
    }

    private var closeButtonConstraints: [NSLayoutConstraint] {
        [
            closeButton.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.CloseButton.topInset
            ),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            closeButton.widthAnchor.constraint(
                equalToConstant: Constants.CloseButton.widthAndHeight
            ),
            closeButton.heightAnchor.constraint(
                equalToConstant: Constants.CloseButton.widthAndHeight
            )
        ]
    }

    private var imageViewConstraints: [NSLayoutConstraint] {
        [
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: Constants.ImageView.topInset
            ),
            imageView.widthAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            imageView.heightAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            changeAvatarView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            changeAvatarView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            changeAvatarView.widthAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            changeAvatarView.heightAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            changeAvatarLabel.centerYAnchor.constraint(equalTo: changeAvatarView.centerYAnchor),
            changeAvatarLabel.centerXAnchor.constraint(equalTo: changeAvatarView.centerXAnchor)
        ]
    }

    private var stackViewConstraints: [NSLayoutConstraint] {
        [
            stackView.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Constants.StackView.bigInset
            ),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
    }

    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        imageView.addSubview(changeAvatarView)
        [
            contentView, scrollView, changeAvatarLabel,
            changeAvatarView, closeButton, imageView, stackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [closeButton, imageView, stackView].forEach {
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate(
            scrollViewConstraints +
            closeButtonConstraints +
            imageViewConstraints +
            stackViewConstraints
        )
    }

    private func setupUI() {
        nameLabel.text = L.Profile.name
        descriptionLabel.text = L.Profile.description
        websiteLabel.text = L.Profile.website
        changeAvatarLabel.text = L.Profile.Avatar.change

        backgroundColor = A.Colors.whiteDynamic.color

        nameTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        websiteTextField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)

        guard let model else { return }
        nameTextField.text = model.name
        avatar = model.avatar
        descriptionTextView.text = model.description
        websiteTextField.text = model.website
    }

    // MARK: - Private methods

    @objc private func textFieldChanged(_ textField: UITextField) {
        trimExtraCharacters(textField: textField)
    }

    private func trimExtraCharacters(
        textField: UITextField,
        maxLength: Int = Constants.textFieldMaxLength
    ) {
        if let text = textField.text, text.count > maxLength {
            textField.text = text.substring(to: maxLength)
        }
    }

    private func trimExtraCharacters(
        textView: UITextView,
        maxLength: Int = Constants.textViewMaxLength
    ) {
        if let text = textView.text, text.count > maxLength {
            textView.text = text.substring(to: maxLength)
        }
    }

    private func updateAvatar() {
        guard let avatar else { return }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: avatar))
    }

    private func registerKeyboardObserver() {
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(notification:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide(notification:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }

    private func removeKeyboardObserver() {
        notificationCenter.removeObserver(self,
                                          name: UIResponder.keyboardWillShowNotification,
                                          object: nil)
        notificationCenter.removeObserver(self,
                                          name: UIResponder.keyboardWillHideNotification,
                                          object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo: NSDictionary = notification.userInfo as? NSDictionary,
              let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        let keyboardSize = keyboardInfo.cgRectValue.size
        scrollView.contentInset.bottom = keyboardSize.height
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardSize.height
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = Constants.ScrollView.bottomContentInset
        scrollView.verticalScrollIndicatorInsets.bottom = Constants.ScrollView.bottomContentInset
    }

}

// MARK: - UITextFieldDelegate

extension EditProfileView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }

}

// MARK: - UITextViewDelegate

extension EditProfileView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        trimExtraCharacters(textView: textView)
    }

}
