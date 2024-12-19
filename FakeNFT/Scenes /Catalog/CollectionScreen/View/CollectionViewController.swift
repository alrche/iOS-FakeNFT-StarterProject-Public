//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Doroteya Galbacheva on 17.12.2024.
//

import UIKit

final class CollectionViewController: UIViewController {
    private let viewModel: CollectionViewModelProtocol
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    private lazy var topView: UIView = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Bold.medium
        return label
    }()
    
    private lazy var firstAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Regular.small
        return label
    }()
    
    private lazy var urlButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.Regular.small
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: A.Colors.blue.color
        ]
        let attributedTitle = NSAttributedString(string: "", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToAuthorURL), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .Regular.small
        label.numberOfLines = .max
        return label
    }()
    
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(NFTCellForCollectionView.self, forCellWithReuseIdentifier: NFTCellForCollectionView.reuseIdentifier)
        collection.isScrollEnabled = false
        return collection
    }()
    
    init(viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        configureNavBar()
        addConstraints()
        loadData()
    }
    
    private func loadData() {
        viewModel.fetchCollections {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.updateCollectionViewHeight()
            }
        }
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        let backButton = UIBarButtonItem(
            image: A.Icons.back.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = A.Colors.black.color
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topImage)
        contentView.addSubview(topView)
        topView.addSubview(nameLabel)
        topView.addSubview(firstAuthorLabel)
        topView.addSubview(urlButton)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(collectionView)
        
        topImage.image = UIImage(named: "peachMaxi")
        nameLabel.text = "Peach"
        firstAuthorLabel.text = L.Catalog.collectionAuthor
        urlButton.setTitle("John Doe", for: .normal)
        descriptionLabel.text = "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей."
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            topImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            topImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            topImage.heightAnchor.constraint(equalToConstant: 310),
            
            topView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 16),
            topView.leadingAnchor.constraint(equalTo: topImage.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: topImage.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 64),
            
            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 28),
            
            firstAuthorLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5),
            firstAuthorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            firstAuthorLabel.widthAnchor.constraint(equalToConstant: 115),
            firstAuthorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            urlButton.leadingAnchor.constraint(equalTo: firstAuthorLabel.trailingAnchor, constant: 4),
            urlButton.heightAnchor.constraint(equalToConstant: 28),
            urlButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            urlButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: topView.bottomAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 72),
            
            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 800)
        collectionViewHeightConstraint?.isActive = true
    }
    
    func updateCollectionViewHeight() {
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let rows = CGFloat((numberOfItems / 3) + (numberOfItems % 3 == 0 ? 0 : 1))
        let itemHeight: CGFloat = 192
        let verticalSpacing: CGFloat = 8
        
        let totalHeight = rows * itemHeight + (rows - 1) * verticalSpacing
        collectionViewHeightConstraint?.constant = totalHeight
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goToAuthorURL() {
        
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCollections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTCellForCollectionView.reuseIdentifier, for: indexPath) as? NFTCellForCollectionView
        else {
            print("Не прошёл каст")
            return UICollectionViewCell()
        }
        
        let nft = viewModel.collection(at: indexPath.row)
        cell.configure(nft: nft)
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 108, height: 192)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftAndRightInset: CGFloat = 16
        return UIEdgeInsets(top: 8, left: leftAndRightInset, bottom: 8, right: leftAndRightInset)
    }
}
