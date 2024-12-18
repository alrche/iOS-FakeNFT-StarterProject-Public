//
//  WebView.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit
import WebKit

// MARK: - WebViewDelegate

protocol WebViewDelegate: AnyObject {
    func didTapCloseButton()
}

// MARK: - WebView

final class WebView: UIView {
    
    // MARK: - Public properties
    
    weak var delegate: WebViewDelegate?
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
        enum CloseButton {
            static let inset: CGFloat = 4
            static let widthAndHeight: CGFloat = 42
        }
    }
    private let presentation: WebViewPresentation

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = A.Colors.whiteDynamic.color
        button.setImage(A.Icons.close.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers

    init(presentation: WebViewPresentation) {
        self.presentation = presentation
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
        addSubview(progressView)
        
        [webView, progressView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        var progressViewTopAnchor: NSLayoutConstraint
        switch presentation {
        case .modal:
            addSubview(closeButton)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
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
            progressViewTopAnchor = progressView.topAnchor.constraint(equalTo: closeButton.bottomAnchor)
        case .navigation:
            progressViewTopAnchor = progressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        }

        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressViewTopAnchor
        ])
    }
    
    @objc private func onTap() {
        switch presentation {
        case .modal: delegate?.didTapCloseButton()
        case .navigation: break
        }
    }
    
}
