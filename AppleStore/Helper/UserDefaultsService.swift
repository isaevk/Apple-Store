//
//  UserDefaultsService.swift
//  AppleStore
//
//  Created by Kirill Dev on 21.02.2023.
//

import UIKit

final class UserDefaultsService {
  
  static var instance = UserDefaultsService()
  
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
