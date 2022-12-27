//
//  UIImageViewExtension.swift
//  ??
//
//  Created by Роман on 23.12.2022.
//

import UIKit

extension UIImageView {
  
  private static let imageLoader = ImageLoaderService(cacheCountLimit: 500)
  
  @MainActor
  func setImage(by url: URL) async throws {
    let image = try await Self.imageLoader.loadImage(for: url)
    
    if !Task.isCancelled {
      self.image = image
    }
  }
  
  func generateImage(height: Int, width: Int) {
    let size = CGSize(width: width, height: height)
    let renderer = UIGraphicsImageRenderer(size: size)
    
    let img = renderer.image { contex in
      let rect = CGRect(x: 0, y: 0, width: width, height: height)
      contex.cgContext.setFillColor(UIColor.systemGray5.cgColor)
      contex.cgContext.addRect(rect)
      contex.cgContext.drawPath(using: .fill)
    }
    
    self.image = img
  }
  
}
