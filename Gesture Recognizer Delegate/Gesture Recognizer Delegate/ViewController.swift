//
//  ViewController.swift
//  Gesture Recognizer Delegate
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var dragView: UIView!
    
    var lp:UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lp = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        self.dragView.addGestureRecognizer(lp)
        lp.numberOfTapsRequired = 1
        
        let p = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        self.dragView.addGestureRecognizer(p)
        p.delegate = self
    }
    
    @objc func longPress(_ lp: UILongPressGestureRecognizer){
        guard let view = lp.view else{
            return
        }
        switch lp.state {
        case .began:
            let anim = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
            anim.toValue = CATransform3DMakeScale(1.3, 1.3, 1)
            anim.fromValue = CATransform3DIdentity
            anim.repeatCount = .infinity
            anim.autoreverses = true
            view.layer.add(anim, forKey:nil)
        case .ended, .cancelled:
            view.layer.removeAllAnimations()
        default: break
        }
        
    }
    
    @objc func drag(_ p : UIPanGestureRecognizer){
        guard let view = p.view else{
            return
        }
        switch p.state {
        case .began, .changed:
            let translate = p.translation(in: self.view)
            view.center = CGPoint(x:view.center.x + translate.x,
                                  y:view.center.y + translate.y)
            p.setTranslation(CGPoint.zero, in: self.view)
        default: break
        }
    }
}

extension ViewController:UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ g: UIGestureRecognizer) -> Bool {
        switch self.lp.state {
        case .possible, .failed:
            return false
        default:
            return true
        }
    }
    
    func gestureRecognizer(_ g: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith
        g2: UIGestureRecognizer) -> Bool {
        return true
    }
}


