//
//  CircleView.swift
//  Three D Touch Gesture 1
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class CircleView: UIView, UIPreviewInteractionDelegate {
    var previous: UIPreviewInteraction!
    
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
    }
    
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
        let scale = transitionProgress + 1
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
        let alpha = ((1 - transitionProgress)*0.5) + 0.3
        self.alpha = alpha
        if ended {
            NotificationCenter.default.post(name: .pop, object: nil)
            self.removeFromSuperview()
        }
    }
    
    func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {
        self.transform = .identity
        self.alpha = 1
    }
}
