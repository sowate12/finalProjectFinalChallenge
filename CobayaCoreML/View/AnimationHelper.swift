//
//  AnimationHelper.swift
//  CobayaCoreML
//
//  Created by zein rezky chandra on 24/01/19.
//  Copyright © 2019 Sania Monica. All rights reserved.
//

import UIKit

class AnimationHelper: UIViewController {
    let shapeLayer = CAShapeLayer()
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0;
            self.view.transform = CGAffineTransform(translationX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(translationX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }) { (finished : Bool) in
            if (finished){
                self.view.removeFromSuperview()
            }
        }
    }
    
    //add loading bar yang merah merah muter
    func addLoading(){
        let center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2-20)
        let circularPath = UIBezierPath(arcCenter: center, radius: 35, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeEnd = 0
    }
    
    //animasiin loading barnya
    func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 5
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = true
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
}

extension AnimationHelper {
    func hapticMedium(){
        let generatorButton = UIImpactFeedbackGenerator(style: .medium)
        generatorButton.prepare()
        generatorButton.impactOccurred()
    }
}
