//
//  MyNFTView.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 15.12.2024.
//

import UIKit

// MARK: - MyNFTView

final class MyNFTView: UIView {

    // MARK: - Public properties

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = A.Colors.whiteDynamic.color
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(MyNFTTableViewCell.self)
        return tableView
    }()

    // MARK: - Private properties

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = A.Colors.blackDynamic.color
        label.font = .Bold.small
        label.text = L.Profile.MyNFT.empty
        label.textAlignment = .center
        return label
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

    // MARK: - Public methods

    func changeState(_ isEnabled: Bool) {
        emptyLabel.isHidden = !isEnabled
        tableView.isHidden = isEnabled
    }

    // MARK: - Private methods

    private func setupUI() {
        backgroundColor = A.Colors.whiteDynamic.color
        emptyLabel.isHidden = true
    }

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            emptyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            emptyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
