//
//  TapAndDragView.swift
//  TouchesDemo
//
//  Created by Mazharul Huq on 9/21/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit

class TapAndDragView: UIView {
    var label:UILabel!
    var decidedDirection = false
    var horiz = false
    var decidedTapOrDrag = false
    var drag = false
    var single = false
    
    override func draw(_ rect: CGRect) {
        self.label = UILabel(frame: CGRect(x: 10, y: 10, width: self.bounds.width - 20, height: 80))
        self.label.numberOfLines = 3
        self.label.font = UIFont(name: "Arial", size: 15)
        self.label.textColor = .white
        self.label.text = "Tap and restricted drag"
        self.addSubview(self.label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with e: UIEvent?) {
        // be undecided
        self.decidedTapOrDrag = false
        // prepare for a tap
        let count = touches.first!.tapCount
        if count == 2{
            self.single = false
            self.decidedTapOrDrag = true
            self.drag = false
            return
            
        }
        // prepare for a drag
        self.decidedDirection = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with e: UIEvent?) {
        if self.decidedTapOrDrag && !self.drag {return}
        //self.superview!.bringSubview(toFront:self)
        let t = touches.first!
        
        self.decidedTapOrDrag = true
        self.drag = true
        if !self.decidedDirection {
            self.decidedDirection = true
            let then = t.previousLocation(in:self)
            let now = t.location(in:self)
            let deltaX = abs(then.x - now.x)
            let deltaY = abs(then.y - now.y)
            self.horiz = deltaX >= deltaY
        }
        let loc = t.location(in:self.superview)
        let oldP = t.previousLocation(in:self.superview)
        let deltaX = loc.x - oldP.x
        let deltaY = loc.y - oldP.y
        var c = self.center
        if self.horiz {
            c.x += deltaX
            label.text = """
                         Dragged horz.to :(\(c.x),\(c.y))
                         """
        } else {
            c.y += deltaY
            label.text = """
                         Dragged vert.to :(\(c.x),\(c.y))
                         """
        }
        self.center = c
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with e: UIEvent?) {
        if !self.decidedTapOrDrag || !self.drag {
            // end for a tap
            let ct = touches.first!.tapCount
            switch ct {
            case 1:
                self.single = true
                delay(0.3) {
                    if self.single {
                        self.label.text = "It was a single tap."
                    }
                }
            case 2:
                self.label.text = "It was a double tap."
            default: break
            }
        }
    }
    


}
