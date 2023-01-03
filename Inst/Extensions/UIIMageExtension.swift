//
//  UIIMageExtension.swift
//  ??
//
//  Created by Роман on 24.12.2022.
//

import UIKit

extension UIImage {
  
  static let background = UIImage(named: "background")
  static let flash = UIImage(named: "flash")
  static let noFlash = UIImage(named: "noFlash")
  static let swap = UIImage(named: "swap")
  
  public func correctlyOrientedImage() -> UIImage {
    if imageOrientation == .up { return self }
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    self.draw(in: rect)
    
    let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return normalizedImage
  }
  
  func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
    let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
    let format = imageRendererFormat
    format.opaque = isOpaque
    return UIGraphicsImageRenderer(size: canvas, format: format).image {
      _ in draw(in: CGRect(origin: .zero, size: canvas))
    }
  }
  
  func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
    let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
    let format = imageRendererFormat
    format.opaque = isOpaque
    return UIGraphicsImageRenderer(size: canvas, format: format).image {
      _ in draw(in: CGRect(origin: .zero, size: canvas))
    }
  }
  
  func rotate(radians: Float) -> UIImage? {
    var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
    // Trim off the extremely small float value to prevent core graphics from rounding it up
    newSize.width = floor(newSize.width)
    newSize.height = floor(newSize.height)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
    let context = UIGraphicsGetCurrentContext()!
    
    // Move origin to middle
    context.translateBy(x: newSize.width/2, y: newSize.height/2)
    // Rotate around middle
    context.rotate(by: CGFloat(radians))
    // Draw the image at its center
    self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
}
