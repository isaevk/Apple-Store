//
//  LounchViewController.swift
//  AppleStore
//
//  Created by Kirill Dev on 21.02.2023.
//

import UIKit

final class LounchViewController: UIViewController {
  
  // MARK: - Private Properties
  private let logoImageView = UIImageView()
  private let photoLoadProgressView = UIProgressView()
  private var timer = Timer()
  
  // MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
    setUI()
  }
  
  // MARK: - IBAction
  @objc private func updateProgressView() {
    if photoLoadProgressView.progress != 1.0 {
      photoLoadProgressView.progress += 0.1 / 1.0
      logoImageView.alpha += 0.1
    } else if photoLoadProgressView.progress == 1 {
      UIView.animate(withDuration: 0.7) {
        self.logoImageView.alpha = 1
        self.timer.invalidate()
      }
    }
  }
  
  // MARK: - Constraints
  private func setConstraints() {
    [logoImageView, photoLoadProgressView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      logoImageView.widthAnchor.constraint(equalToConstant: 200),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      photoLoadProgressView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
      photoLoadProgressView.widthAnchor.constraint(equalToConstant: 300),
      photoLoadProgressView.heightAnchor.constraint(equalToConstant: 15),
      photoLoadProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  // MARK: - Setup UI
  private func setUI() {
    view.backgroundColor = .white
    logoImageView.image = UIImage(named: "logo")
    logoImageView.alpha = 0.1
    
    photoLoadProgressView.progressViewStyle = .bar
    photoLoadProgressView.setProgress(0.0, animated: true)
    createTimer()
  }
  
  private func createTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(updateProgressView),
                                 userInfo: nil,
                                 repeats: true)
  }
}
