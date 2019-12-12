//
//  PopAnimator.swift
//  GOGOVAN-MOBILE-DEMO
//
//  Created by Noel Obaseki on 04/12/2019.
//  Copyright © 2019 NoelObaseki. All rights reserved.
//

import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.1
    var originFrame = CGRect.zero
    var presenting = true
   
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let location_list_view = presenting ? toView : transitionContext.view(forKey: .from) else { return }
        
        let initialFrame = presenting ? originFrame : location_list_view.frame
        let finalFrame = presenting ? location_list_view.frame : originFrame
        
        
        let xScaleFactor = presenting
            ? initialFrame.width / finalFrame.width
            : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting
            ? initialFrame.height / finalFrame.height
            : finalFrame.height / initialFrame.height
        let scaleFactor = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
        location_list_view.transform = scaleFactor
        location_list_view.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
        }
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(location_list_view)
        

        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.0,
            animations: {
                location_list_view.transform = self.presenting ? .identity : scaleFactor
                location_list_view.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }
        ) { _ in
            if !self.presenting {
                let viewController = transitionContext.viewController(forKey: .to) as! MapViewController
                viewController.bottomUiView?.isHidden = false
            }
            transitionContext.completeTransition(true)
        }
        
    }
}


