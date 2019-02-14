//
//  AnimationHelper.swift
//  CobayaCoreML
//
//  Created by zein rezky chandra on 24/01/19.
//  Copyright © 2019 Sania Monica. All rights reserved.
//

import UIKit

/// Some animations to add to the view controller
class AnimationHelper: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    
    /// Animation when the ViewController appears
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0;
            self.view.transform = CGAffineTransform(translationX: 1.0, y: 1.0)
        }
    }
    
    /// Animation when the ViewController disappears
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(translationX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }) { (finished : Bool) in
            if (finished){
                self.view.removeFromSuperview()
            }
        }
    }
    
    /// The red circle that appears when scanning and it's attributes
    func addLoading(){
        let center = CGPoint(x: self.view.frame.width/2 - 2, y: self.view.frame.height - 95.5)
        let circularPath = UIBezierPath(arcCenter: center, radius: 39, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeEnd = 0
    }
    
    /// How the red circle behaves
    func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2.5
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = true
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
}

extension AnimationHelper {
    
    /// The haptic that occurs when the user does something
    func hapticMedium(){
        let generatorButton = UIImpactFeedbackGenerator(style: .medium)
        generatorButton.prepare()
        generatorButton.impactOccurred()
    }
}
