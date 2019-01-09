//
//  ViewController.swift
//  Dragging with Springing Action
//
//  Created by Mazharul Huq on 1/8/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var noVelocityView: UIView!
    @IBOutlet var velocityView: UIView!
    
    var noVelocityCenter = CGPoint.zero
    var withVelocityCenter = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let noVelocityPan = UIPanGestureRecognizer(target: self, action: #selector(dragNoVelocity(_:)))
        self.noVelocityView.addGestureRecognizer(noVelocityPan)
        
        let withVelocityPan = UIPanGestureRecognizer(target: self, action: #selector(dragWithVelocity(_:)))
        self.velocityView.addGestureRecognizer(withVelocityPan)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.noVelocityCenter = self.noVelocityView.center
        self.withVelocityCenter = self.velocityView.center
    }
    
    @objc func dragNoVelocity(_ p:UIPanGestureRecognizer){
        guard let view = p.view else{
            return
        }
        let translate = p.translation(in: self.view)
        switch p.state{
        case .began, .changed:
            view.center = CGPoint(x:view.center.x + translate.x,
                                  y:view.center.y + translate.y)
            p.setTranslation(CGPoint.zero, in: self.view)
        case .ended, .cancelled:
            let animation = UIViewPropertyAnimator(duration: 4.0, timingParameters: UISpringTimingParameters(dampingRatio: 0.3, initialVelocity: .zero))
            animation.addAnimations {
                view.center = self.noVelocityCenter
            }
            animation.startAnimation()
        default: break
        }
    }
    
    @objc func dragWithVelocity(_ p:UIPanGestureRecognizer){
        guard let view = p.view else{
            return
        }
        let translate = p.translation(in: self.view)
        switch p.state{
        case .began, .changed:
            view.center = CGPoint(x:view.center.x + translate.x,
                                  y:view.center.y + translate.y)
            p.setTranslation(CGPoint.zero, in: self.view)
        case .ended, .cancelled:
            let velocity = p.velocity(in: view.superview!)
            let distx = abs(view.center.x - self.withVelocityCenter.x)
            let disty = abs(view.center.y - self.withVelocityCenter.y)
            let animation = UIViewPropertyAnimator(duration: 4.0, timingParameters: UISpringTimingParameters(dampingRatio: 0.3, initialVelocity: CGVector(dx: velocity.x/distx, dy: 4*velocity.y/disty)))
            animation.addAnimations {
                view.center = self.withVelocityCenter
            }
            animation.startAnimation()
        default: break
        }
    }
}


