//
//  AboutProductViewController.swift
//  AppleStore
//
//  Created by Kirill Dev on 07.02.2023.
//

import UIKit

final class AboutProductViewController: UIViewController {
  
  // MARK: -Public Properties
  var productModel: ProductModel?
  
  // MARK: - Private Properties
  let itemImage = UIImageView()
  let itemDescriptionLabel = UILabel()
  
  // MARK: -Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
    setUI()
  }
  
  // MARK: -Override Properties
  override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
  
  // MARK: -Constraints
  private func setConstraints() {
    [itemImage, itemDescriptionLabel].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    NSLayoutConstraint.activate([
      itemImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      itemImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      itemImage.widthAnchor.constraint(equalToConstant: 300),
      itemImage.heightAnchor.constraint(equalToConstant: 300),
      
      itemDescriptionLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 30),
      itemDescriptionLabel.widthAnchor.constraint(equalToConstant: 300),
      itemDescriptionLabel.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  // MARK: -Setup UI
  private func setUI() {
    view.backgroundColor = .opaqueSeparator
    itemDescriptionLabel.font = .boldSystemFont(ofSize: 30)
    itemImage.image = productModel?.image
    itemDescriptionLabel.text = productModel?.description
  }
}
