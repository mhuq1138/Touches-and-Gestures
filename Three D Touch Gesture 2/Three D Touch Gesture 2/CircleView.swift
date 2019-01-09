//
//  CircleView.swift
//  Three D Touch Gesture 2
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class CircleView: UIView, UIPreviewInteractionDelegate {
    
    
    var previous: UIPreviewInteraction!
    var animator:UIViewPropertyAnimator!
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.isOpaque = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        let p = UIBezierPath(ovalIn: rect)
        UIColor.blue.setFill()
        p.fill()
    }
    
    override func didMoveToSuperview() {
        self.previous = UIPreviewInteraction(view: self)
        self.previous.delegate = self
        self.makeAnimator()
    }
    
    func makeAnimator() {
        self.animator = UIViewPropertyAnimator(duration: 2, curve: .linear) {
            [unowned self] in
            self.transform = CGAffineTransform(scaleX: 3, y: 3)
        }
    }
    
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
        self.animator.fractionComplete = min(max(transitionProgress, 0.05), 0.95)
        if ended {
            self.animator.stopAnimation(false)
            self.animator.finishAnimation(at: .end)
            NotificationCenter.default.post(name: .pop, object: nil)
            self.removeFromSuperview()
        }
    }
    
    func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {
        self.animator.pauseAnimation()
        self.animator.isReversed = true
        self.animator.addCompletion {_ in self.makeAnimator() }
        self.animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.01)
    }
    
}
