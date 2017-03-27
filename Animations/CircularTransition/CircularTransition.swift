//
//  CircularTransition.swift
//  CircularTransitionAnimation
//
//  Created by Hank Chiang on 2017/3/25.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    
    var circleView = UIView()
    
    var startPoint = CGPoint.zero
    
    var circleColor = UIColor.white
    
    var duration = 0.5
    
    enum CircularTransitionMode {
        case present, dismiss
    }
    
    var transitionMode = CircularTransitionMode.present
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circleView = UIView()
                circleView.frame = frameForCircleView(withViewCenter: viewCenter, size: viewSize, startPoint: startPoint)
                circleView.layer.cornerRadius = circleView.frame.height / 2
                circleView.center = startPoint
                circleView.backgroundColor = circleColor
                circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circleView)
                
                presentedView.center = startPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: { 
                    self.circleView.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1.0
                    presentedView.center = viewCenter
                }, completion: { (complete) in
                    transitionContext.completeTransition(complete)
                })
            }
        } else {
            if let returningView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circleView.frame = frameForCircleView(withViewCenter: viewCenter, size: viewSize, startPoint: startPoint)
                circleView.layer.cornerRadius = circleView.frame.height / 2
                circleView.center = startPoint
                
                UIView.animate(withDuration: duration, animations: { 
                    self.circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startPoint
                    returningView.alpha = 0
                }, completion: { (complete) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circleView.removeFromSuperview()
                    
                    transitionContext.completeTransition(complete)
                })
            }
        }
    }
    
    private func frameForCircleView(withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let maxX = fmax(startPoint.x, viewSize.width - startPoint.x)
        let maxY = fmax(startPoint.y, viewSize.height - startPoint.y)
        let diameter = sqrt(pow(maxX, 2) + pow(maxY, 2)) * 2
        let size = CGSize(width: diameter, height: diameter)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
}
