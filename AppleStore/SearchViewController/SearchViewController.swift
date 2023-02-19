//
//  SearchViewController.swift
//  AppleStore
//
//  Created by Kirill Dev on 06.02.2023.
//

import UIKit
import WebKit

final class SearchViewController: UIViewController {
  
  // MARK: - Private Properties
  private let macBookView =  MacbookItemView()
  private let airPodsView = AirPodsItemView()
  private let searchLabel = UILabel()
  private let searchTextField = UITextField()
  private let recentItemsLabel = UILabel()
  private let clearButton = UIButton()
  
  private lazy var recentlyItemsScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.backgroundColor = .black
    scrollView.contentSize = contentSize
    scrollView.frame = CGRect(x: 20, y: 300, width: 350, height: 200)
    return scrollView
  }()
  
  private lazy var contentView: UIView = {
    let contentView = UIView()
    contentView.backgroundColor = .black
    contentView.frame.size = contentSize
    return contentView
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 20
    return stackView
  }()
  
  private var contentSize: CGSize {
    CGSize(width: view.frame.width + 400, height: 150)
  }
  
  // MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setConstraints()
    sentInfoToAboutVC()
  }
  
  // MARK: - Constraints
  private func setConstraints() {
    [searchLabel, searchTextField, recentItemsLabel, clearButton].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      searchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      searchLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
      searchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
      searchTextField.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 10),
      searchTextField.widthAnchor.constraint(equalToConstant: 350),
      recentItemsLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 35),
      recentItemsLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
      clearButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 35),
      clearButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
    ])
    
    // Add views on StackView
    [macBookView, airPodsView].forEach { stackView.addArrangedSubview($0) }
    
    for view in stackView.arrangedSubviews {
      NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: 150),
        view.heightAnchor.constraint(equalToConstant: 200)
      ])
    }
  }
  
  // MARK: - Setup UI
  private func setUI() {
    searchLabel.text = "Search"
    searchLabel.font = .boldSystemFont(ofSize: 40)
    searchLabel.textColor = .white
    recentItemsLabel.text = "Recently Viewed"
    recentItemsLabel.font = .boldSystemFont(ofSize: 27)
    recentItemsLabel.textColor = .white
    clearButton.setTitle("Clear", for: .normal)
    clearButton.setTitleColor(UIColor.systemBlue, for: .normal)
    
    searchTextField.placeholder = "What are you looking for?"
    searchTextField.borderStyle = .roundedRect
    searchTextField.backgroundColor = .lightGray
    guard let magnifierImage = UIImage(systemName: "magnifyingglass"), let microImage = UIImage(systemName: "mic.fill") else { return }
    searchTextField.addImagesTxtField(txtField: searchTextField,
                                      leftImage: magnifierImage,
                                      rightImage: microImage)
    
    view.addSubview(recentlyItemsScrollView)
    recentlyItemsScrollView.addSubview(contentView)
    contentView.addSubview(stackView)
  }
  
  // MARK: - Switch to AboutVC
  private func sentInfoToAboutVC() {
    let aboutVC = AboutProductViewController()
    
    macBookView.complition = { [weak self] url  in
      aboutVC.myURL = url
      self?.navigationController?.pushViewController(aboutVC, animated: true)
    }
    
    airPodsView.complition = { [weak self] url in
      aboutVC.myURL = url
      self?.navigationController?.pushViewController(aboutVC, animated: true)
    }
  }
}
