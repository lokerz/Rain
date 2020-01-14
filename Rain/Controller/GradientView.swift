//
//  GradientView.swift
//  Rain
//
//  Created by Ridwan Abdurrasyid on 15/05/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class GradientView: UIView, CAAnimationDelegate {

    var startColor : UIColor?
    var endColor : UIColor?
    var animated : Bool = false
    var reversed : Bool = false
    var opacityAnimated : Bool = false
    var colorAnimated : Bool = false
    
    
    override class var layerClass : AnyClass{
        return CAGradientLayer.self
    }
    
    
    override func layoutSubviews() {
        let gradientLayer = layer as! CAGradientLayer
        
        gradientLayer.colors = [startColor!.cgColor, endColor!.cgColor]
        gradientLayer.locations = [0 , 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.1)
        gradientLayer.opacity = 1
        
       
        if animated{
            let locationAnimation = CABasicAnimation(keyPath: "locations")
            locationAnimation.fromValue = [0, 1]
            locationAnimation.toValue = [0.3, 1]
            locationAnimation.duration = .random(in: 20...30)
            locationAnimation.autoreverses = true
            locationAnimation.repeatCount = Float.infinity

            let angleAnimation = CABasicAnimation(keyPath: "startPoint")
            angleAnimation.fromValue = reversed ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0)
            angleAnimation.toValue = reversed ? CGPoint(x: 0, y: 0) : CGPoint(x: 1, y: 0)
            angleAnimation.duration = .random(in: 5...15)
            angleAnimation.autoreverses = true
            angleAnimation.repeatCount = Float.infinity

            gradientLayer.add(locationAnimation, forKey: nil)
            gradientLayer.add(angleAnimation, forKey: nil)

        }
        
        if opacityAnimated{
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 1
            opacityAnimation.toValue = 0
            opacityAnimation.beginTime = CACurrentMediaTime() + 5
            opacityAnimation.duration = .random(in: 10...15)
            opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            opacityAnimation.repeatCount = Float.infinity
            opacityAnimation.autoreverses = true
            
            gradientLayer.add(opacityAnimation, forKey: nil)
        }
        
    }
}
