//
//  MyView.swift
//  Hit Testing
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//
/************************************************************************
 The button on IB is a subview of this view. Normally, we cannot touch
 a subview outside its superview. But hit test on this view can override
 this and the button can respond to a touch.
 ************************************************************************/
import UIKit

class MyView: UIView {
    
    override func hitTest(_ point: CGPoint, with e: UIEvent?) -> UIView? {
        if let result = super.hitTest(point, with:e) {
            return result
        }
        //Following returns hit test on button
        for sub in self.subviews.reversed() {
            let pt = self.convert(point, to:sub)
            if let result = sub.hitTest(pt, with:e) {
                return result
            }
        }
        return nil
    }
    
}
