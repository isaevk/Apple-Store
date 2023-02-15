//
//  SceneDelegate.swift
//  AppleStore
//
//  Created by Kirill Dev on 06.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let tabBarController = UITabBarController()
    tabBarController.tabBar.backgroundColor = .quaternaryLabel
    tabBarController.viewControllers = [BuilderVC.makeShopVC(), BuilderVC.makeForYouVC(),
                                        BuilderVC.makeSearchVC(), BuilderVC.makeBagVC()]
    
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
  }
}
