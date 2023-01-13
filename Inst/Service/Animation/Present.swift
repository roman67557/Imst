//
//  Present.swift
//  ??
//
//  Created by Роман on 28.02.2022.
//

import Foundation
import UIKit

final class Present: NSObject, UIViewControllerAnimatedTransitioning {
  
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
    let background = setupBackground(toView: toView)
    let viewToAnimate = setupViewToAnimate()
    let containerView = transitionContext.containerView
    
    containerView.addSubview(background)
    containerView.addSubview(toView)
    containerView.addSubview(viewToAnimate)
    
    toView.isHidden = true
    
    guard let image = viewToAnimate.image else {
      transitionContext.completeTransition(true)
      return
    }
    let imageAspectRatio = image.size.width / image.size.height
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
  
  private func setupBackground(toView: UIView) -> UIView {
    let background = UIView(frame: UIScreen.main.bounds)
    background.backgroundColor = toView.backgroundColor
    background.alpha = 0
    
    return background
  }
  
  private func setupViewToAnimate()  -> UIImageView {
    let viewToAnimate = UIImageView(frame: originFrame)
    viewToAnimate.autoresizingMask = .flexibleWidth
    viewToAnimate.contentMode = .scaleAspectFill
    viewToAnimate.layer.masksToBounds = true
    viewToAnimate.image = image
    viewToAnimate.clipsToBounds = true
    viewToAnimate.layer.cornerRadius = rounding
    
//    DispatchQueue.main.async {
      switch self.image.imageOrientation {
      case .right:
        guard let data = self.image.pngData() else { return UIImageView() }
        let imageToSend = UIImage(data: data)?.rotate(radians: .pi / 2)
        viewToAnimate.image = imageToSend
      default:
        break
      }
//    }
    
    return viewToAnimate
  }
  
}
