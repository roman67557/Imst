//
//  Present.swift
//  ??
//
//  Created by Роман on 28.02.2022.
//

import Foundation
import UIKit

class Present: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let originFrame: CGRect
  private let duration: TimeInterval = 0.2
  private let rounding: CGFloat = 0
  
  private let image: UIImage
  
  init(image: UIImage, originframe: CGRect) {
    self.image = image
    self.originFrame = originframe
    super.init()
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let toView = transitionContext.view(forKey: .to) else {
      transitionContext.completeTransition(true)
      return
    }
    
    let finalFrame = toView.frame
    
    let background = UIView(frame: UIScreen.main.bounds)
    background.backgroundColor = toView.backgroundColor
    background.alpha = 0
    
    let viewToAnimate = UIImageView(frame: originFrame)
    viewToAnimate.image = image
    viewToAnimate.layer.cornerRadius = rounding
    viewToAnimate.contentMode = .scaleAspectFill
    viewToAnimate.clipsToBounds = true
    
    let containerView = transitionContext.containerView
    containerView.addSubview(background)
    containerView.addSubview(toView)
    containerView.addSubview(viewToAnimate)
    
    toView.isHidden = true
    
    let imageAspectRatio = viewToAnimate.image!.size.width / viewToAnimate.image!.size.height
    let finalImageheight = finalFrame.width / imageAspectRatio
    
    UIView.animate(withDuration: duration, animations: {
      viewToAnimate.frame.size.width = finalFrame.width
      viewToAnimate.frame.size.height = finalImageheight
      viewToAnimate.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      background.alpha = 1
    }, completion:{ _ in
      toView.isHidden = false
      background.removeFromSuperview()
      viewToAnimate.removeFromSuperview()
      transitionContext.completeTransition(true)
    })
    
  }
}
