//
//  SmallCollectionViewCell.swift
//  wq
//
//  Created by Роман on 02.01.2022.
//

import UIKit

class SmallCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "SmallCollectionViewCell"
  
  public let searchPageImageView = UIImageView()
  private let activityIndicatorView = UIActivityIndicatorView()
  
  private var loadImageTask: Task<Void, Never>?
  
  public func configure<T>(with photo: T) {
    
    addSubViews()
    setupColor()
    setupConstraints()
    
    if photo is Results {
      let result = photo as? Results
      guard let string = result?.urls.regular, let url = URL(string: string) else { return }
      setupImageView(url: url)
    } else {
      guard let shootedImage = photo as? ShooterdImages else { return }
      setupImageView(shootedImage: shootedImage)
    }
  }
  
  private func addSubViews() {
    
    [searchPageImageView, activityIndicatorView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
  }
  
  private func setupColor() {
    self.backgroundColor = .systemGray5
  }
  
  private func setupImageView(url: URL) {
    loadImageTask?.cancel()
    
    loadImageTask = Task { [weak self] in
      self?.searchPageImageView.image = nil
      self?.searchPageImageView.backgroundColor = .systemGray5
      self?.activityIndicatorView.startAnimating()
      
      do {
        try await self?.searchPageImageView.setImage(by: url)
        if Task.isCancelled { return }
        self?.searchPageImageView.contentMode = .scaleAspectFill
        self?.searchPageImageView.clipsToBounds = true
      } catch {
        if Task.isCancelled { return }
        self?.searchPageImageView.image = nil
      }
      
      self?.activityIndicatorView.stopAnimating()
    }
  }
  
  private func setupImageView(shootedImage: ShooterdImages) {
    guard let data = shootedImage.img else { return }
    let image = UIImage(data: data)
    
    searchPageImageView.image = image
    searchPageImageView.clipsToBounds = true
    searchPageImageView.contentMode = .scaleAspectFill
  }
  
  private func setupConstraints() {
    searchPageImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    searchPageImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    searchPageImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    searchPageImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    
    activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    searchPageImageView.image = nil
  }
  
}

