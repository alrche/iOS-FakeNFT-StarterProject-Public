//
//  WebView.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit
import WebKit

// MARK: - WebView
final class WebView: UIView {
    
    // MARK: - Public properties
    var webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = A.Colors.whiteDynamic.color
        return webView
    }()
    
    var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = A.Colors.blackDynamic.color
        return progressView
    }()
    
    // MARK: - Private properties
    private enum Constants {
        static let backButtonWidthAndHeight: CGFloat = 42
        enum CloseButton {
            static let inset: CGFloat = 4
            static let widthAndHeight: CGFloat = 42
        }
    }
    private var backButtonAction: () -> Void
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = A.Colors.whiteDynamic.color
        button.setImage(A.Icons.close.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    init(_ backButtonAction: @escaping () -> Void) {
        self.backButtonAction = backButtonAction
        
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupLayout() {
        backgroundColor = A.Colors.whiteDynamic.color
        
        addSubview(webView)
        addSubview(closeButton)
        addSubview(progressView)
        
        [webView, progressView, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: Constants.CloseButton.inset
            ),
            safeAreaLayoutGuide.trailingAnchor.constraint(
                equalTo: closeButton.trailingAnchor,
                constant: Constants.CloseButton.inset
            ),
            closeButton.widthAnchor.constraint(
                equalToConstant: Constants.CloseButton.widthAndHeight
            ),
            closeButton.heightAnchor.constraint(
                equalToConstant: Constants.CloseButton.widthAndHeight
            )
        ])
        
        NSLayoutConstraint.activate([
            progressView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            progressView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            progressView.topAnchor.constraint(equalTo: closeButton.bottomAnchor)
        ])
    }
    
    @objc private func onTap() {
        backButtonAction()
    }
    
}
