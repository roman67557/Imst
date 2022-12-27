//
//  UIIMageExtension.swift
//  ??
//
//  Created by Роман on 24.12.2022.
//

import UIKit

extension UIImage {
  
  static let background = UIImage(named: "background")
  
  public func correctlyOrientedImage() -> UIImage {
    guard imageOrientation != .up else { return self }
    
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(in: CGRect(origin: .zero, size: size))
    guard let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
    UIGraphicsEndImageContext()
    
    return normalizedImage
  }
  
}
