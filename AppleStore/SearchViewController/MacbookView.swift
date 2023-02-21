//
//  MacbookItemView.swift
//  AppleStore
//
//  Created by Kirill Dev on 07.02.2023.
//

import UIKit

final class MacbookItemView: UIView {
  
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
  
  // MARK: - IBAction
  @objc private func imageTapped() {
    complition?(URLs.mac)
  }
  
  // MARK: - Override init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setInfo()
  }
  
 @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private methods
  private func setInfo() {
    backgroundColor = .quaternaryLabel
    layer.cornerRadius = 10
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
    
    addSubview(itemImage)
    addSubview(itemDescriptionLabel)
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    itemImage.isUserInteractionEnabled = true
    itemImage.addGestureRecognizer(tapGestureRecognizer)
  }
}
