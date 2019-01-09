//
//  SingleOrDoubleTapView.swift
//  TouchesDemo
//
//  Created by Mazharul Huq on 9/20/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit

class SingleOrDoubleTapView: UIView {

    var label:UILabel!
    var single = true
    
    override func draw(_ rect: CGRect) {
        self.label = UILabel(frame: CGRect(x: 10, y: 10, width: self.bounds.width - 20, height: 30))
        self.label.font = UIFont(name: "Arial", size: 25)
        self.label.textColor = .white
        self.label.text = "Single or double tap?"
        self.addSubview(self.label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let count = touches.first!.tapCount
        if count == 2 {
            self.single = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let count = touches.first!.tapCount
        switch count{
        case 1:
            self.single = true
            delay(0.3) {
                if self.single { // no second tap intervened
                    self.label.text = "It was a single tap"
                }
            }
        case 2:
            self.label.text = "It was a double tap"
        default: break
        }
    }

}
