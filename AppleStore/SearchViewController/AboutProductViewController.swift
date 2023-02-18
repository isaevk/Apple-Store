//
//  AboutProductViewController.swift
//  AppleStore
//
//  Created by Kirill Dev on 07.02.2023.
//

import UIKit
import WebKit

final class AboutProductViewController: UIViewController {
  
  // MARK: - Public Properties
  var myURL: String?
  
  // MARK: - Private Properties
  private let webView = WKWebView()
  private let goBackItem = UIBarButtonItem(systemItem: .rewind)
  private let goForwardItem = UIBarButtonItem(systemItem: .fastForward)
  private let resetItem = UIBarButtonItem(systemItem: .refresh)
  private let activityIndicator = UIActivityIndicatorView()
  private let aplication = UIApplication.shared
  
  // MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
    setupUI()
  }
  
  // MARK: -IBAction
  @objc private func goBackAction() {
    guard webView.canGoBack else { return }
    webView.goBack()
  }
  
  @objc private func goForwardAction() {
    guard webView.canGoForward else { return }
    webView.goForward()
  }
  
  @objc private func resetAction() {
    webView.reload()
  }
  
  // MARK: - Private methods
  private func setupConsteaints() {
    webView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(webView)
    
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
      webView.widthAnchor.constraint(equalToConstant: view.frame.width)
    ])
  }
  
  private func setupUI() {
    guard let url = URL(string: myURL!) else { return }
    let myRequest = URLRequest(url: url)
    webView.load(myRequest)
    
    goBackItem.action = #selector(goBackAction)
    goForwardItem.action = #selector(goForwardAction)
    resetItem.action = #selector(resetAction)
    navigationItem.rightBarButtonItems = [goForwardItem, goBackItem, resetItem]
    setupConsteaints()
  }
}

// MARK: - Extension WKNavigationDelegate
extension AboutProductViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    aplication.isNetworkActivityIndicatorVisible = true
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    aplication.isNetworkActivityIndicatorVisible = false
    goBackItem.isEnabled = webView.canGoBack
    goForwardItem.isEnabled = webView.canGoForward
  }
}
