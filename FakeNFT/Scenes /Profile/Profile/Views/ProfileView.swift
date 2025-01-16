//
//  ProfileView.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit
import Kingfisher
import SkeletonView

// MARK: - ProfileView

final class ProfileView: UIView {

    // MARK: - Public properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = A.Colors.whiteDynamic.color
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.register(ProfileTableViewCell.self)
        return tableView
    }()

    // MARK: - Private properties

    private enum Constants {
        enum ContentView {
            static let horizontalSpacing: CGFloat = 16
        }
        enum ImageView {
            static let topInset: CGFloat = 20
            static let widthAndHeight: CGFloat = 70
        }
        enum TableView {
            static let topInset: CGFloat = 44
            static let horizontalSpacing: CGFloat = 20
            static let maxHeight: CGFloat = 300
            static let height: CGFloat = 54
        }
        enum DescriptionLabel {
            static let topInset: CGFloat = 20
            static let bottomInset: CGFloat = 12
        }
        enum NameLabel {
            static let leadingInset: CGFloat = 16
        }
        enum ScrollView {
            static let bottomContentInset: CGFloat = 20
        }
    }
    private let viewModel: ProfileViewModel
    private var model: ProfileModel? {
        viewModel.model
    }

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset.bottom = Constants.ScrollView.bottomContentInset
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.ImageView.widthAndHeight / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isSkeletonable = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Bold.medium
        label.numberOfLines = 2
        label.textColor = A.Colors.blackDynamic.color
        label.isSkeletonable = true
        return label
    }()

    private let descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = A.Colors.whiteDynamic.color
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.sizeToFit()
        textView.isEditable = false
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .foregroundColor: A.Colors.blackDynamic.color,
            .font: UIFont.Regular.small
        ]
        textView.typingAttributes = attributes
        textView.isSkeletonable = true
        return textView
    }()

    private let websiteLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.medium
        label.textColor = A.Colors.blue.color
        label.isUserInteractionEnabled = true
        label.isSkeletonable = true
        return label
    }()

    private lazy var tableViewHeightAnchor = {
        self.tableView.heightAnchor.constraint(equalToConstant: 0)
    }()

    // MARK: - Initializers

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupLayout()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods

    override func updateConstraints() {
        self.tableView.layoutIfNeeded()
        self.tableViewHeightAnchor.constant = min(
            Constants.TableView.maxHeight,
            self.tableView.contentSize.height
        )
        super.updateConstraints()
    }

    // MARK: - Public methods

    func initialize(gestureRecognizer: UIGestureRecognizer) {
        websiteLabel.addGestureRecognizer(gestureRecognizer)
    }

    func updateUI() {
        guard let model else { return }
        websiteLabel.text = model.website
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        updateAvatar()
        tableView.reloadData()
    }

    func changeSkeletonState(isShown: Bool) {
        if isShown {
            contentView.showAnimatedSkeleton()
        } else {
            contentView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
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

    private var imageViewConstraints: [NSLayoutConstraint] {
        [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.ImageView.topInset
            ),
            imageView.widthAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            imageView.heightAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight)
        ]
    }

    private var nameLabelConstraints: [NSLayoutConstraint] {
        [
            nameLabel.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: Constants.NameLabel.leadingInset
            ),
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            contentView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ]
    }

    private var descriptionLabelConstraints: [NSLayoutConstraint] {
        [
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Constants.DescriptionLabel.topInset
            ),
            contentView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor)
        ]
    }

    private var websiteLabelConstraints: [NSLayoutConstraint] {
        [
            websiteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            websiteLabel.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Constants.DescriptionLabel.bottomInset
            ),
            contentView.trailingAnchor.constraint(equalTo: websiteLabel.trailingAnchor)
        ]
    }

    private var tableViewConstraints: [NSLayoutConstraint] {
        [
            contentView.leadingAnchor.constraint(
                equalTo: tableView.leadingAnchor,
                constant: Constants.TableView.horizontalSpacing
            ),
            tableView.topAnchor.constraint(
                equalTo: websiteLabel.bottomAnchor,
                constant: Constants.TableView.topInset
            ),
            tableView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.TableView.horizontalSpacing
            ),
            contentView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            tableViewHeightAnchor
        ]
    }

    private func setupUI() {
        backgroundColor = A.Colors.whiteDynamic.color
        guard let model else { return }
        websiteLabel.text = model.website
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        updateAvatar()
    }

    private func updateAvatar() {
        guard let model else { return }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: model.avatar))
    }

    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        [imageView, nameLabel, descriptionLabel, websiteLabel, tableView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate(
            scrollViewConstraints +
            imageViewConstraints +
            nameLabelConstraints +
            descriptionLabelConstraints +
            websiteLabelConstraints +
            tableViewConstraints
        )
    }

}
