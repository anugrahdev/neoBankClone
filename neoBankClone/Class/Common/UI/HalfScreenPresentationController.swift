//
//  HalfScreenPresentationController.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import UIKit

class HalfScreenTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfScreenPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class HalfScreenPresentationController: UIPresentationController {

    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        return blurEffectView
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }
        let height = containerView.bounds.height / 1.65
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        if let containerView = containerView {
            blurEffectView.frame = containerView.bounds
            containerView.insertSubview(blurEffectView, at: 0)
        }
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.layer.cornerRadius = 10
        presentedView?.clipsToBounds = true
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = containerView else { return }
        blurEffectView.frame = containerView.bounds
        containerView.insertSubview(blurEffectView, at: 0)
        blurEffectView.alpha = 0
        guard let coordinator = presentedViewController.transitionCoordinator else {
            blurEffectView.alpha = 0.7
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0.7
        }, completion: nil)
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        guard let coordinator = presentedViewController.transitionCoordinator else {
            blurEffectView.alpha = 0.0
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0.0
        }, completion: { _ in
            self.blurEffectView.removeFromSuperview()
        })
    }
}
