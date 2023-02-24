//
//  UserDefaultsService.swift
//  AppleStore
//
//  Created by Kirill Dev on 21.02.2023.
//

import UIKit

//extension UIImageView {
//
//  func loadImage() {
//    guard let data = UserDefaults.standard.data(forKey: "KEY") else {
//      self.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
//      return
//    }
//    guard let decoded = try? PropertyListDecoder().decode(Data.self, from: data) else { return }
//    let image = UIImage(data: decoded)
//    self.image = image?.withRoundedCorners(radius: 120)
//  }
//}
//
//
//class SaveImage {
//
//  func loadImage(image: UIImageView) {
//    guard let data = UserDefaults.standard.data(forKey: "KEY") else {
//      image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
//      return
//    }
//    guard let decoded = try? PropertyListDecoder().decode(Data.self, from: data) else { return }
//    let image = UIImage(data: decoded)
//    self.image = image?.withRoundedCorners(radius: 120)
//  }
//}
//

//final class SaveImage {
//
//  static let shared = SaveImage()
//
//  var image: UIImage = {
//    var image = UIImageView()
//    guard let data = UserDefaults.standard.data(forKey: "KEY") else {
//      guard let errorImage = UIImage(systemName: "person.crop.circle.badge.exclamationmark") else { return }
//      image.image = errorImage
//      return image
//    }
//    guard let decoded = try? PropertyListDecoder().decode(Data.self, from: data) else { return }
//    let decodedImage = UIImage(data: decoded)
//    image.image = decodedImage?.withRoundedCorners(radius: 120)
//    return image
//  }()
//
//  private init() {}
//
//
//}

final class UserDefaultsService {
  
  static private var _instance: UserDefaultsService! = nil
  
  static var sharedInstance: UserDefaultsService {
    get {
      if UserDefaultsService._instance == nil {
        UserDefaultsService._instance = UserDefaultsService()
      }
      
      return UserDefaultsService._instance
    }
  }
  
  private init() {}
  
  func set(key: String, value: Any?) {
    UserDefaults.standard.set(value, forKey: key)
  }
  
  func get<T>(key: String) -> T? {
    let value = UserDefaults.standard.object(forKey: key)
    return value as? T
  }
  
  func remove(key: String) {
    UserDefaults.standard.removeObject(forKey: key)
  }
}
