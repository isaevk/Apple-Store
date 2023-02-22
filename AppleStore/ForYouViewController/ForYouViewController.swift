//
//  ForYouViewController.swift
//  AppleStore
//
//  Created by Kirill Dev on 06.02.2023.
//

import UIKit

final class ForYouViewController: UIViewController {
  
  // MARK: - Private Properties
  private let titleLabel = UILabel()
  private var avatarImageView = UIImageView()
  private let topLineView = UIView()
  private let whatsHappeningLabel = UILabel()
  private let orderButton = UIButton()
  private let orderProgressView = UIProgressView()
  private let handledLabel = UILabel()
  private let progress = Progress()
  private let sentLabel = UILabel()
  private let deliveredLabel = UILabel()
  
  // MARK: - Override methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraints()
    setUI()
    setTimerProgress()
  }
  
  // MARK: - IBAction
  @objc private func imageTapped() {
    let vc = UIImagePickerController()
    vc.sourceType = .photoLibrary
    vc.delegate = self
    vc.allowsEditing = true
    present (vc, animated: true)
  }
  
  @objc private func didTouchButton() {
    present(BuilderVC.makeLounchVC(), animated: true)
  }
  
  // MARK: - Constraints
  private func setConstraints() {
    [titleLabel, avatarImageView, topLineView, whatsHappeningLabel, orderButton, orderProgressView, handledLabel,  sentLabel, deliveredLabel].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
      titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
      avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      avatarImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
      avatarImageView.widthAnchor.constraint(equalToConstant: 75),
      avatarImageView.heightAnchor.constraint(equalToConstant: 75),
      topLineView.widthAnchor.constraint(equalToConstant: view.bounds.width - 40),
      topLineView.heightAnchor.constraint(equalToConstant: 1),
      topLineView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
      topLineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
      whatsHappeningLabel.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 20),
      whatsHappeningLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
      orderButton.topAnchor.constraint(equalTo: whatsHappeningLabel.bottomAnchor, constant: 20),
      orderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      orderButton.heightAnchor.constraint(equalToConstant: 200),
      orderButton.widthAnchor.constraint(equalToConstant: 350),
      orderProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      orderProgressView.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: 5),
      orderProgressView.widthAnchor.constraint(equalToConstant: 350),
      orderProgressView.heightAnchor.constraint(equalToConstant: 10),
      handledLabel.topAnchor.constraint(equalTo: orderProgressView.bottomAnchor, constant: 5),
      handledLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22),
      sentLabel.topAnchor.constraint(equalTo: orderProgressView.bottomAnchor, constant: 5),
      sentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      deliveredLabel.topAnchor.constraint(equalTo: orderProgressView.bottomAnchor, constant: 5),
      deliveredLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22)
    ])
  }
  
  // MARK: - Setup UI
  private func setUI() {
    view.backgroundColor = .white
    titleLabel.font = .boldSystemFont(ofSize: 40)
    titleLabel.text = "For you"
    topLineView.backgroundColor = .gray
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    avatarImageView.isUserInteractionEnabled = true
    avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    
    whatsHappeningLabel.font = .boldSystemFont(ofSize: 30)
    whatsHappeningLabel.text = "Here's what's happening."
    
    handledLabel.text = "Handled"
    handledLabel.font = .boldSystemFont(ofSize: 15)
    sentLabel.text = "Sent"
    sentLabel.font = .boldSystemFont(ofSize: 15)
    deliveredLabel.text = "Delivered"
    deliveredLabel.font = .boldSystemFont(ofSize: 15)
    
    orderProgressView.progressTintColor = .green
    orderProgressView.progress = 0.1
    orderProgressView.observedProgress = progress
    
    orderButton.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
    orderButton.createAppleStoreButton()
    
    guard let data = UserDefaults.standard.data(forKey: "Avatar") else {
      avatarImageView.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
      return
    }
    guard let decoded = try? PropertyListDecoder().decode(Data.self, from: data) else { return }
    let image = UIImage(data: decoded)
    avatarImageView.image = image
  }
  
  // MARK: - Setup Timer
  private func setTimerProgress() {
    progress.totalUnitCount = 2
    var count: Int64 = 0
    
    Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { timer in
      if self.progress.isCancelled {
        timer.invalidate()
      }
      if self.progress.fractionCompleted == 1 {
        self.progress.cancel()
      }
      self.progress.completedUnitCount = count
      count += 1
    }
  }
}

// MARK: - Extension UIImagePickerControllerDelegate
extension ForYouViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
      
      guard let data = image.jpegData(compressionQuality: 0.5) else { return }
      let encoded = try? PropertyListEncoder().encode(data)
      
      UserDefaultsService.instance.set(key: "Avatar", value: encoded)
      avatarImageView.image = image
    }
    
    picker.dismiss(animated: true)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
  }
}

// MARK: - Extension UINavigationControllerDelegate
extension ForYouViewController: UINavigationControllerDelegate {
  
}
