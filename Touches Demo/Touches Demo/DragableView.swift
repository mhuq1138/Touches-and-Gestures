//
//  DragableView.swift
//  TouchesDemo
//
//  Created by Mazharul Huq on 9/21/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit

class DragableView: UIView {

    var label:UILabel!
    
    override func draw(_ rect: CGRect) {
        self.label = UILabel(frame: CGRect(x: 10, y: 10, width: self.bounds.width - 20, height: 80))
        self.label.numberOfLines = 3
        self.label.font = UIFont(name: "Arial", size: 15)
        self.label.textColor = .white
        self.label.text = "Drag in any direction"
        self.addSubview(self.label)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.first!
        let loc = t.location(in: self.superview)
        let oldP = t.previousLocation(in: self.superview)
        let deltaX = loc.x - oldP.x
        let deltaY = loc.y - oldP.y
        var c = self.center
        //The view's center moved by changes in the finger position
        c.x += deltaX
        c.y += deltaY
        self.center = c
        label.text = """
                     Dragged to:
                     (\(c.x), \(c.y))
                     """
    }
}
