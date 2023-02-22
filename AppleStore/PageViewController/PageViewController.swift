//
//  PageViewController.swift
//  AppleStore
//
//  Created by Kirill Dev on 22.02.2023.
//

import UIKit

final class PageViewController: UIPageViewController {
  
  private var pagesVC = [UIViewController]()
  
  private let skipButton = UIButton()
  private let nextButton = UIButton()
  private let pageControl = UIPageControl()
  private var initialPage = 0
  
  // Animation
  private var pageControlBottomAnchor: NSLayoutConstraint?
  private var skipButtonTopAnchor: NSLayoutConstraint?
  private var nextButtonTopAnchor: NSLayoutConstraint?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    layout()
  }
  
  @objc private func skipTapped() {
    let lastPage = pagesVC.count - 1
    pageControl.currentPage = lastPage
    
    goToSpecificPage(index: lastPage, ofViewControllers: pagesVC)
    animateControlsIfNeeded()
  }
  
  @objc private func nextTapped() {
    pageControl.currentPage += 1
    goToNextPage()
    animateControlsIfNeeded()
  }
  
  @objc private func pageControllTapped(_ sender: UIPageControl) {
    setViewControllers([pagesVC[sender.currentPage]], direction: .forward, animated: true)
    animateControlsIfNeeded()
  }
  
  
  private func layout() {
    [pageControl, skipButton, nextButton].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
      pageControl.heightAnchor.constraint(equalToConstant: 20),
      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      skipButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
    ])
    
    // for animations
    pageControlBottomAnchor = view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2)
    skipButtonTopAnchor = skipButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
    nextButtonTopAnchor = nextButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
    
    pageControlBottomAnchor?.isActive = true
    skipButtonTopAnchor?.isActive = true
    nextButtonTopAnchor?.isActive = true
  }
  
  private func setUI() {
    dataSource = self
    delegate = self
    
    let page1 = OnboardingViewController(imageName: "apple_logo",
                                         titleText: "Welcome",
                                         subtitleText: "Apple store good to see you")
    
    let page2 = OnboardingViewController(imageName: "swift",
                                         titleText: "Buy books",
                                         subtitleText: "Learn and grow")
    
    let page3 = OnboardingViewController(imageName: "mushroom",
                                         titleText: "Have fun",
                                         subtitleText: "It's just a mushroom")
    
    let page4 = MainTabBarController()
    
    [page1, page2, page3, page4].forEach {
      pagesVC.append($0)
    }
    setViewControllers([pagesVC[initialPage]], direction: .forward, animated: true)
    
    style()
  }
  
  private func style() {
    
    pageControl.currentPageIndicatorTintColor = .black
    pageControl.pageIndicatorTintColor = .systemGray2
    pageControl.numberOfPages = pagesVC.count
    pageControl.currentPage = initialPage
    pageControl.addTarget(self, action: #selector(pageControllTapped), for: .valueChanged)
    
    skipButton.setTitleColor(.systemBlue, for: .normal)
    skipButton.setTitle("Skip", for: .normal)
    skipButton.addTarget(self, action: #selector(skipTapped), for: .primaryActionTriggered)
    
    nextButton.setTitleColor(.systemBlue, for: .normal)
    nextButton.setTitle("Next", for: .normal)
    nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
  }
}

// MARK: - UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = pagesVC.firstIndex(of: viewController) else { return nil }
    
    if currentIndex == 0 {
      return pagesVC.last
    } else {
      return pagesVC[currentIndex - 1]
    }
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = pagesVC.firstIndex(of: viewController) else { return nil }
    
    if currentIndex < pagesVC.count - 1 {
      return pagesVC[currentIndex + 1]
    } else {
      return pagesVC.first
    }
  }
}

// MARK: - UIPageViewControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool ) {
    guard let viewControllers = pageViewController.viewControllers else { return }
    guard let currentIndex = pagesVC.firstIndex(of: viewControllers[0]) else { return }
    
    pageControl.currentPage = currentIndex
    animateControlsIfNeeded()
  }
  
  private func animateControlsIfNeeded() {
    let lastPage = pageControl.currentPage == pagesVC.count - 1
    
    if lastPage {
      hideControls()
    } else {
      showControls()
    }
    
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5,
                                                   delay: 0,
                                                   options: [.curveEaseOut],
                                                   animations: { self.view.layoutIfNeeded()
    })
  }
  
  private func hideControls() {
    pageControlBottomAnchor?.constant = -80
    skipButtonTopAnchor?.constant = -80
    nextButtonTopAnchor?.constant = -80
  }
  
  private func showControls() {
    pageControlBottomAnchor?.constant = 16
    skipButtonTopAnchor?.constant = 16
    nextButtonTopAnchor?.constant = 16
  }
}
