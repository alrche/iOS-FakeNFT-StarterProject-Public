//
//  PaymentView.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 27.12.2024.
//

import Foundation
import SnapKit
import UIKit
import SkeletonView
final class PaymentView: UIView {
    //MARK: - Private Properties
    let colletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let totalSpacing: CGFloat = 7 * 1
        let totalInsets: CGFloat = 16 * 2
        let availableWidth = UIScreen.main.bounds.width - totalInsets - totalSpacing
        let itemWidth = availableWidth / 2
        let itemHeight: CGFloat = 46
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 7
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PaymentCollectionViewCell.self)
        collectionView.backgroundColor = A.Colors.whiteDynamic.color
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let payTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = A.Colors.lightGrayDynamic.color
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 12
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.register(PaymentBottomTableViewCell.self)
        return tableView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaymentView {
    //MARK: - Private Methods
    private func setupUI() {
        addSubview(colletionView)
        addSubview(payTableView)
        colletionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        payTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(186)
        }
    }
}
