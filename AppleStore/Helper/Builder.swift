//
//  Builder.swift
//  AppleStore
//
//  Created by Kirill Dev on 06.02.2023.
//

import UIKit

final class BuilderVC {
  
  static func makeShopVC() -> UIViewController {
    let shopVC = ShopViewController()
    shopVC.title = "Shop"
    shopVC.tabBarItem.image = UIImage(systemName: "macbook.and.iphone")
    return shopVC
  }
  
  static func makeForYouVC() -> UIViewController {
    let forYouVC = ForYouViewController()
    forYouVC.title = "For You"
    forYouVC.tabBarItem.image = UIImage(systemName: "person.circle")
    return forYouVC
  }
  
  static func makeSearchVC() -> UIViewController {
    let searchVC = UINavigationController(rootViewController: SearchViewController())
    searchVC.title = "Search"
    searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    return searchVC
  }
  
  static func makeBagVC() -> UIViewController {
    let bagVC = BagViewController()
    bagVC.title = "Bag"
    bagVC.tabBarItem.image = UIImage(systemName: "bag")
    return bagVC
  }
  
  static func makeLounchVC() -> UIViewController {
    let vc = LounchViewController()
    return vc
  }
}
