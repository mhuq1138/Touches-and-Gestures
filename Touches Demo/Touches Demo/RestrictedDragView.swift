//
//  RestrictedDragView.swift
//  TouchesDemo
//
//  Created by Mazharul Huq on 9/21/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit

class RestrictedDragView: UIView {

    var label:UILabel!
    var initial = false
    var horizontal = false
    
    override func draw(_ rect: CGRect) {
        self.label = UILabel(frame: CGRect(x: 10, y: 10, width: self.bounds.width - 20, height: 80))
        self.label.numberOfLines = 3
        self.label.font = UIFont(name: "Arial", size: 15)
        self.label.textColor = .white
        self.label.text = "Drag verical or horizontal"
        self.addSubview(self.label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.initial = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.first!
        
        if self.initial {
            self.initial = false
            let then = t.previousLocation(in: self)
            let now = t.location(in: self)
            self.horizontal = abs(then.x - now.x) >= abs(then.y - now.y) //determines whether horizontal
        }
        
        let loc = t.location(in: self.superview)
        let oldP = t.previousLocation(in: self.superview)
        let deltaX = loc.x - oldP.x
        let deltaY = loc.y - oldP.y
        var c = self.center
        //Can be restricted to horizontal or vertical by
        //removing if or else block content
        if self.horizontal {
            c.x += deltaX
            self.label.text = """
                         Dragged horz.to :
                         (\(c.x),\(c.y))
                         """
        } else {
            c.y += deltaY
            self.label.text = """
                           Dragged vert.to :
                           (\(c.x),\(c.y))
                           """
        }
        self.center = c
    }

}
