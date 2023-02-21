//
//  UIButton+.swift
//  AppleStore
//
//  Created by Kirill Dev on 21.02.2023.
//

import UIKit

extension UIButton {
  
  func createAppleStoreButton() {
    self.setTitle("Your order has been sent", for: .normal)
    var configuration = UIButton.Configuration.bordered()
    configuration.subtitle = "1 item, delivery tomorrow"
    configuration.image = UIImage(named: "pods_smoll")
    configuration.buttonSize = .large
    configuration.titlePadding = 10
    configuration.imagePadding = 50
    configuration.background.cornerRadius = 10
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 10)
    self.configuration = configuration
  }
}
