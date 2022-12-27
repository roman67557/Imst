//
//  AnimationWithRoundedImage.swift
//  ??
//
//  Created by Роман on 11.04.2022.
//

//import Foundation
//import UIKit
//
//enum AnimationType {
//    case present
//    case dismiss
//}
//
//class TransitionAnimator: NSObject {
//
//    let presentationStartButton: UIView
//    let animationDuration: Double
//    let animationType: AnimationType
//
//    init(presentationStartButton: UIView, animationDuration: Double, animationType: AnimationType) {
//        self.presentationStartButton = presentationStartButton
//        self.animationDuration = animationDuration
//        self.animationType = animationType
//    }
//
//}
//
//extension TransitionAnimator: UIViewControllerAnimatedTransitioning {
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return TimeInterval(animationDuration)
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        switch animationType {
//        case .present:
//            presentAnimation(transitionContext: transitionContext)
//        case .dismiss:
//            dismissAnimation(transitionContext: transitionContext)
//        }
//    }
//
//    func presentAnimation(transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//
//        guard let presentedVIewController = transitionContext.viewController(forKey: .to) as? ProfilePhotoViewController,
//              let fromView = transitionContext.viewController(forKey: .from) as? UserViewController,
//              let presentedView = transitionContext.view(forKey: .to) else {
//                  transitionContext.completeTransition(false)
//                  return
//              }
//        let finalFrame = transitionContext.finalFrame(for: presentedVIewController)
//        let startButtonFrame = presentationStartButton.convert(presentationStartButton.bounds, to: containerView)
//        let startButtonCenter = CGPoint(x: startButtonFrame.midX, y: startButtonFrame.midY)
//
//        let circleView = UIImageView(frame: startButtonFrame)
//        circleView.image = fromView.myPhotoImageView.image
//        circleView.layer.cornerRadius = circleView.frame.height / 2
//        circleView.clipsToBounds = true
//
//        containerView.addSubview(presentedView)
//        containerView.addSubview(circleView)
//
//        presentedView.center = startButtonCenter
//
//        circleView.center = presentedView.center
//        presentedView.isHidden = true
//        presentationStartButton.isHidden = true
//
//        let imageAspectRatio = circleView.image!.size.width / circleView.image!.size.height
//        let finalImageheight = finalFrame.width / imageAspectRatio
//
//        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
//            circleView.layer.cornerRadius = 0
//
//            circleView.frame.size.width = finalFrame.width
//            circleView.frame.size.height = finalImageheight
//            circleView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
//
//        } completion: { finished in
//            circleView.removeFromSuperview()
//            presentedView.isHidden = false
//            transitionContext.completeTransition(finished)
//        }
//    }
//
//    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//
//        guard let toVC = transitionContext.viewController(forKey: .to) as? UserViewController,
//              let fromVC = transitionContext.viewController(forKey: .from) as? ProfilePhotoViewController,
//              let toView = transitionContext.view(forKey: .to)
//              else {
//
//                  transitionContext.completeTransition(false)
//                  return
//        }
//
////        let size = fromVC.profilePhotoCollectionView.frame.size
////        let convertedRect = fromVC.profilePhotoCollectionView.convert(fromVC.profilePhotoCollectionView.bounds, to: containerView)
////        let originFrame = CGRect(origin: convertedRect.origin, size: size)
//
//        let finalFrame = presentationStartButton.convert(presentationStartButton.bounds, to: containerView)
//
////        let viewToAnimate = UIImageView(frame: originFrame)
////        viewToAnimate.center = CGPoint(x: convertedRect.midX, y: convertedRect.midY)
////        viewToAnimate.image = toVC.myPhotoImageView.image
////
////        viewToAnimate.layer.cornerRadius = presentationStartButton.frame.height / 2
////        viewToAnimate.clipsToBounds = true
////
////        containerView.addSubview(toView)
////        containerView.addSubview(viewToAnimate)
////
////        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
////
//////            fromVC.view.isHidden = false
////            viewToAnimate.frame.size.width = finalFrame.width
////            viewToAnimate.frame.size.height = finalFrame.height
////            viewToAnimate.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
////            viewToAnimate.contentMode = .scaleAspectFit
////        } completion: { finished in
////            self.presentationStartButton.isHidden = false
////            viewToAnimate.removeFromSuperview()
////            transitionContext.completeTransition(finished)
////        }
//
//    }
//}
