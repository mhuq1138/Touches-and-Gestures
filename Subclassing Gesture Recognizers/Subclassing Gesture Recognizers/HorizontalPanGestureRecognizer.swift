//
//  HorizontalPanGestureRecognizer.swift
//  Subclassing Gesture Recognizers
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class HorizontalPanGestureRecognizer: UIPanGestureRecognizer {
    var startLocation:CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        self.startLocation = touches.first!.location(in: self.view!.superview)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible{
            let location = touches.first!.location(in: self.view!.superview)
            let deltaX = abs(location.x  - self.startLocation.x)
            let deltaY = abs(location.y  - self.startLocation.y)
            if deltaY >= deltaX{
                self.state = .failed
            }
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func translation(in view: UIView?) -> CGPoint {
        var translation = super.translation(in: view)
        translation.y = 0.0
        return translation
    }
}
