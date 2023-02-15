//
//  SearchViewController.swift
//  AppleStore
//
//  Created by Kirill Dev on 06.02.2023.
//

import UIKit

final class SearchViewController: UIViewController {
  
  // MARK: -Private Properties
  private let firstRecentlyView =  FirstItemView()
  private let secondRecentlyView = SecondItemView()
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
  
  // MARK: -Override methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setConstraints()
    sentInfoToAboutVC()
  }
  
  // MARK: -Constraints
  private func setConstraints() {
    [searchLabel, searchTextField, recentItemsLabel, clearButton].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
    ])
    
    // Add views on StackView
    [firstRecentlyView, secondRecentlyView].forEach { stackView.addArrangedSubview($0) }
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
    ])
    
    for view in stackView.arrangedSubviews {
      NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: 150),
        view.heightAnchor.constraint(equalToConstant: 200)
      ])
    }
  }
  
  // MARK: -Setup UI
  private func setUI() {
    firstRecentlyView.setInfo()
    secondRecentlyView.setInfo()
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
    searchTextField.addImagesTxtField(txtField: searchTextField,
                                      leftImage: UIImage(systemName: "magnifyingglass")!,
                                      rightImage: UIImage(systemName: "mic.fill")!)
    
    view.addSubview(recentlyItemsScrollView)
    recentlyItemsScrollView.addSubview(contentView)
    contentView.addSubview(stackView)
  }
  
  // MARK: -Switch to AboutVC
  private func sentInfoToAboutVC() {
    let aboutVC = AboutProductViewController()
    let markBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: nil, action: nil)
    let shareBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: nil, action: nil)
    aboutVC.navigationItem.rightBarButtonItems =  [markBarButtonItem, shareBarButtonItem]
    
    firstRecentlyView.complition = { [weak self] model  in
      aboutVC.productModel = model
      self?.navigationController?.pushViewController(aboutVC, animated: true)
    }
    
    secondRecentlyView.complition = { [weak self] model in
      aboutVC.productModel = model
      self?.navigationController?.pushViewController(aboutVC, animated: true)
    }
  }
}
