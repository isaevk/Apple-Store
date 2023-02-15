//
//  UITextField+.swift
//  AppleStore
//
//  Created by Kirill Dev on 07.02.2023.
//

import UIKit

extension UITextField {
  
  func addImagesTxtField(txtField: UITextField, leftImage: UIImage, rightImage: UIImage) {
    let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: leftImage.size.width, height: leftImage.size.height))
    let rightImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: rightImage.size.width, height: rightImage.size.height))
    leftImageView.image = leftImage
    rightImageView.image = rightImage
    txtField.leftView = leftImageView
    txtField.rightView = rightImageView
    txtField.leftViewMode = .always
    txtField.rightViewMode = .always
  }
}
