//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Aliaksandr Charnyshou on 14.12.2024.
//

import UIKit
import WebKit

// MARK: - WebViewController

final class WebViewController: UIViewController {
    
    // MARK: - Private properties

    private let webViewModel: WebViewModelProtocol
    private let url: URL
    private let titleString: String?
    private var estimatedProgressObservation: NSKeyValueObservation?
    private let webView: WebView
    private let presentation: WebViewPresentation

    // MARK: - Initializers

    init(
        webViewModel: WebViewModelProtocol,
        url: URL,
        presentation: WebViewPresentation,
        title: String? = nil
    ) {
        self.presentation = presentation
        self.webView = WebView(presentation: presentation)
        self.webViewModel = webViewModel
        self.url = url
        self.titleString = title
        super.init(nibName: nil, bundle: nil)
        webView.delegate = self
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridden methods

    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerEstimatedProgressObserver()
        bind()
        configureNavigationBarIfNeeded()
        load(url: url)
    }
    
    // MARK: - Private methods
    
    private func bind() {
        webViewModel.onProgressChange = { [weak self] progress in
            self?.setProgressValue(progress)
        }
        webViewModel.onProgressHide = { [weak self] isHidden in
            self?.setProgressHidden(isHidden)
        }
    }
    
    private func registerEstimatedProgressObserver() {
        estimatedProgressObservation = webView.webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self else { return }
                 self.webViewModel.didUpdateProgressValue(self.webView.webView.estimatedProgress)
             }
        )
    }
    
    private func load(url: URL) {
        let request = URLRequest(url: url)
        webView.webView.load(request)
    }
    
    private func setProgressValue(_ newValue: Float) {
        webView.progressView.progress = newValue
    }
    
    private func setProgressHidden(_ isHidden: Bool) {
        webView.progressView.isHidden = isHidden
    }

    private func configureNavigationBarIfNeeded() {
        guard presentation == .navigation else { return }
        let leftButton = UIBarButtonItem(
            image: A.Icons.back.image,
            style: .plain,
            target: self,
            action: #selector(back)
        )
        navigationItem.setLeftBarButton(leftButton, animated: false)
        navigationItem.title = titleString
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - WebViewController

extension WebViewController: WebViewDelegate {
    func didTapCloseButton() {
        dismiss(animated: true)
    }
}
