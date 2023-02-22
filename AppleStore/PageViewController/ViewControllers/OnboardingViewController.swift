//
//  OnboardingViewController.swift
//  AppleStore
//
//  Created by Kirill Dev on 22.02.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
  
  private let stackView = UIStackView()
  
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  
  
  init(imageName: String, titleText: String, subtitleText: String) {
    super.init(nibName: nil, bundle: nil)
    self.imageView.image = UIImage(named: imageName)
    self.titleLabel.text = titleText
    self.subtitleLabel.text = subtitleText
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setConstraints()
  }
  
  private func setConstraints() {
    [imageView, titleLabel, subtitleLabel].forEach {
      stackView.addArrangedSubview($0)
    }
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      
      subtitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.trailingAnchor, multiplier: 2)
    ])
  }
  
  private func setUI() {
    [stackView, imageView, titleLabel, subtitleLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 20
    
    imageView.contentMode = .scaleAspectFit
    
    titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    
    subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    subtitleLabel.textAlignment = .center
    subtitleLabel.numberOfLines = 0
  }
}
