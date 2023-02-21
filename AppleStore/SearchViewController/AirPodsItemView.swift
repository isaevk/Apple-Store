//
//  AirPodsItemView.swift
//  AppleStore
//
//  Created by Kirill Dev on 07.02.2023.
//

import UIKit

final class AirPodsItemView: UIView {
  
  // MARK: - Public Properties
  var complition: ((String) -> Void)?
  
  // MARK: - Private Properties
  private let itemImage = UIImageView()
  
  private let itemDescriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.lineBreakMode =  .byTruncatingTail
    label.numberOfLines = 2
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  // MARK: - IBActions
  @objc private func imageTapped() {
    complition?(ProductModel.pods)
  }
  
  // MARK: - Override init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setInfo()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private methods
  private func setInfo() {
    backgroundColor = .quaternaryLabel
    layer.cornerRadius = 10
    itemImage.image = UIImage(named: "airPods")
    itemDescriptionLabel.text = "AirPods Pro (2nd generation)"
    
    itemImage.frame = CGRect(x: 10,
                             y: 10,
                             width: 130,
                             height: 130)
    itemDescriptionLabel.frame = CGRect(x: 10,
                                        y: Int(itemImage.frame.height + 10),
                                        width: 130,
                                        height: 50)
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    itemImage.isUserInteractionEnabled = true
    itemImage.addGestureRecognizer(tapGestureRecognizer)
    
    addSubview(itemImage)
    addSubview(itemDescriptionLabel)
  }
}
