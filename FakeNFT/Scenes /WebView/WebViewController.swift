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

    private let webViewModel: WebViewModel
    private let url: URL
    private var estimatedProgressObservation: NSKeyValueObservation?
    private lazy var webView = WebView {
        self.didTapCloseButton()
    }
    
    // MARK: - Initializers

    init(webViewModel: WebViewModel, url: URL) {
        self.webViewModel = webViewModel
        self.url = url
        super.init(nibName: nil, bundle: nil)
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
        load(url: url)
    }
    
    // MARK: - Private  methods
    
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
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }
    
}
