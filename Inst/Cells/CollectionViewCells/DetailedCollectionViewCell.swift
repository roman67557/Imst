//
//  DetailedCollectionViewCell.swift
//  ??
//
//  Created by Роман on 04.02.2022.
//

import UIKit

class DetailedCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
  
  static var identifier = "DetailedCell"
  
  private let activityIndicatorView = UIActivityIndicatorView(style: .large)
  private let scrollImg = UIScrollView()
  let imgView = UIImageView()
  
  private var loadImageTask: Task<Void, Never>?
  
  public func configure<T>(with photo: T) {
    
    if photo is Results {
      let result = photo as? Results
      
      guard let string = result?.urls.full,
            let url = URL(string: string),
            let height = result?.height,
            let width = result?.width else { return }
      
//      imgView.generateImage(height: height, width: width)
//      imgView.image = .background
      setupImageView(url: url)
    } else {
      guard let shootedImage = photo as? ShooterdImages else { return }
      setupImageView(shootedImage: shootedImage)
    }
    
    addSubViews()
    setupScroll()
    setupConstraints()
  }
  
  private func addSubViews() {
    self.addSubview(scrollImg)
    scrollImg.addSubview(imgView)
    addSubview(activityIndicatorView)
    
    [scrollImg, imgView, activityIndicatorView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func setupScroll() {
    
    scrollImg.delegate = self
    scrollImg.alwaysBounceVertical = false
    scrollImg.alwaysBounceHorizontal = false
    scrollImg.showsVerticalScrollIndicator = false
    scrollImg.showsHorizontalScrollIndicator = false
    scrollImg.isScrollEnabled = false
    scrollImg.flashScrollIndicators()
    
    scrollImg.minimumZoomScale = 1.0
    scrollImg.maximumZoomScale = 4.0
    
    let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
    doubleTapGest.numberOfTapsRequired = 2
    scrollImg.addGestureRecognizer(doubleTapGest)
  }
  
  private func setupImageView(url: URL) {
    loadImageTask?.cancel()
    
    loadImageTask = Task { [weak self] in
      self?.imgView.contentMode = .scaleAspectFit
      self?.imgView.image = .background
      self?.activityIndicatorView.startAnimating()
      do {
        try await self?.imgView.setImage(by: url)
        if Task.isCancelled { return }
      } catch {
        if Task.isCancelled { return }
        self?.imgView.image = .background
      }
      
      self?.activityIndicatorView.stopAnimating()
    }
  }
  
  private func setupImageView(shootedImage: ShooterdImages) {
    
    guard let data = shootedImage.img, let image = UIImage(data: data) else { return }
    
    imgView.image = image
    imgView.contentMode = .scaleAspectFit
  }
  
  @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
    
    if (scrollImg.zoomScale > scrollImg.minimumZoomScale) {
      scrollImg.setZoomScale(scrollImg.minimumZoomScale, animated: true)
    } else {
      scrollImg.setZoomScale(scrollImg.maximumZoomScale, animated: true)
    }
  }
  
  func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
    
    var zoomRect = CGRect.zero
    zoomRect.size.height = imgView.frame.size.height
    zoomRect.size.width  = imgView.frame.size.width
    let newCenter = imgView.convert(center, from: scrollImg)
    zoomRect.origin.x = newCenter.x
    zoomRect.origin.y = newCenter.y
    return zoomRect
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.imgView
  }
  
  private func setupConstraints() {
    scrollImg.topAnchor.constraint(equalTo: topAnchor).isActive = true
    scrollImg.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    scrollImg.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    scrollImg.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    
    imgView.centerXAnchor.constraint(equalTo: scrollImg.centerXAnchor).isActive = true
    imgView.centerYAnchor.constraint(equalTo: scrollImg.centerYAnchor).isActive = true
    imgView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    imgView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
    
    activityIndicatorView.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imgView.image = nil
    scrollImg.setZoomScale(1, animated: true)
  }
  
}
