//
//  DismissingAnimator.swift
//  Inspirato
//
//  Created by Justin Vallely on 6/12/17.
//  Copyright © 2017 Inspirato. All rights reserved.
//

import Foundation
import UIKit

final class Dismiss: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let finalFrame: CGRect
  private let duration: TimeInterval = 0.2
  private let image: UIImage
  
  init(finalFrame: CGRect, image: UIImage) {
    self.finalFrame = finalFrame
    self.image = image
    super.init()
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let toView = transitionContext.view(forKey: .to),
          let fromVC = transitionContext.viewController(forKey: .from) else {
      transitionContext.completeTransition(true)
      return
    }
    
    let containerView = transitionContext.containerView
    
    let width = fromVC.view.frame.width
    let height = width / (image.size.width / image.size.height)
    let size = CGSize(width: width, height: height)
    let convertedRect = fromVC.view.convert(fromVC.view.bounds , to: containerView)
    let originFrame = CGRect(origin: convertedRect.origin , size: size)
    
    let viewToAnimate = UIImageView(frame: originFrame)
    viewToAnimate.center = CGPoint(x: convertedRect.midX , y: convertedRect.midY )
    viewToAnimate.image = image
    viewToAnimate.contentMode = .scaleAspectFill
    viewToAnimate.clipsToBounds = true
    
    containerView.addSubview(toView)
    containerView.addSubview(viewToAnimate)
    
    fromVC.view.isHidden = true
    
    UIView.animate(withDuration: duration, animations: {
      viewToAnimate.frame.size.width = self.finalFrame.width
      viewToAnimate.frame.size.height = self.finalFrame.height
      viewToAnimate.center = CGPoint(x: self.finalFrame.midX, y: self.finalFrame.midY)
      viewToAnimate.contentMode = .scaleAspectFill

    }, completion: { _ in
      viewToAnimate.removeFromSuperview()
      transitionContext.completeTransition(true)
    })
  }
  
}
