//
//  CartView.swift
//  FakeNFT
//
//  Created by Богдан Топорин on 19.12.2024.
//
import Foundation
import UIKit
import SnapKit
import SkeletonView

final class CartView: UIView {
    
    // MARK: - Public properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = A.Colors.whiteDynamic.color
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(CartTableViewCell.self)
        return tableView
    }()
    
    let payTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = A.Colors.lightGrayDynamic.color
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 12
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.register(CartPayTableViewCell.self)
        return tableView
    }()
    
    let emptyView: EmptyView = {
            let view = EmptyView()
            view.isHidden = true
            return view
        }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = A.Colors.whiteDynamic.color
        addSubview(payTableView)
        payTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(76)
        }
        
        addSubview(emptyView)
                emptyView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
    }
    
    private func setupLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
}
