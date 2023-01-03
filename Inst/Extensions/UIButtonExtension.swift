//
//  UIButtonExtension.swift
//  Inst
//
//  Created by Роман on 28.12.2022.
//

import UIKit

extension UIButton {
  private func imageWithColor(color: UIColor) -> UIImage? {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
  
  public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    self.setBackgroundImage(imageWithColor(color: color), for: state)
  }
}
