//
//  MainTabBarController.swift
//  AppleStore
//
//  Created by Kirill Dev on 15.02.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
  
  // MARK: -Override methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
  
  // MARK: - Private Methods
  private func setupUI() {
    tabBar.backgroundColor = .quaternaryLabel
    self.viewControllers = [BuilderVC.makeShopVC(), BuilderVC.makeForYouVC(),
                            BuilderVC.makeSearchVC(), BuilderVC.makeBagVC()]
  }
}
