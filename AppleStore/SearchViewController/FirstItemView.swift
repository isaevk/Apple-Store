//
//  FirstItemView.swift
//  AppleStore
//
//  Created by Kirill Dev on 07.02.2023.
//

import UIKit

final class FirstItemView: UIView {
  
  // MARK: - Public Properties
  let itemImage = UIImageView()

  // MARK: - Private Properties
  private let itemDescriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.lineBreakMode =  .byTruncatingTail
    label.numberOfLines = 2
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  // MARK: - IBAction
  @objc private func imageTapped() {
    complition?(itemImage.image!, itemDescriptionLabel.text!)
  }
  
  // MARK: - Public methods
  var complition: ((UIImage, String) -> Void)?
  
  func setInfo() {
    self.backgroundColor = .quaternaryLabel
    self.layer.cornerRadius = 10
    itemImage.image = UIImage(named: "macBook")
    itemDescriptionLabel.text = "16-inch MacBook Pro Apple M1 Pro Chip with 10-Core"
    
    itemImage.frame = CGRect(x: 10,
                             y: 10,
                             width: 130,
                             height: 130)
    itemDescriptionLabel.frame = CGRect(x: 10,
                                        y: Int(itemImage.frame.height + 10),
                                        width: 130,
                                        height: 50)
    
    
    self.addSubview(itemImage)
    self.addSubview(itemDescriptionLabel)
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    itemImage.isUserInteractionEnabled = true
    itemImage.addGestureRecognizer(tapGestureRecognizer)
  }
}
