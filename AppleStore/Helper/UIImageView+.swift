//
//  UIImageView+.swift
//  AppleStore
//
//  Created by Kirill Dev on 21.02.2023.
//

import UIKit

extension UIImageView {
  
  func loadImage() {
    guard let data = UserDefaults.standard.data(forKey: "KEY") else {
      self.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
      return
    }
    guard let decoded = try? PropertyListDecoder().decode(Data.self, from: data) else { return }
    let image = UIImage(data: decoded)
    self.image = image?.withRoundedCorners(radius: 120)
  }
}
