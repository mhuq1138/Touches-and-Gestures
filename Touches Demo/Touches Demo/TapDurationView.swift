//
//  TapDurationView.swift
//  TouchesDemo
//
//  Created by Mazharul Huq on 9/20/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit

class TapDurationView: UIView {
    var label:UILabel!
    var time:TimeInterval = 0.0
    
    override func draw(_ rect: CGRect) {
        self.label = UILabel(frame: CGRect(x: 10, y: 10, width: self.bounds.width - 20, height: 30))
        self.label.font = UIFont(name: "Arial", size: 25)
        self.label.textColor = .white
        self.label.text = "Short or long tap?"
        self.addSubview(self.label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.time = touches.first!.timestamp
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let diff = event!.timestamp - self.time
        if diff < 0.3 {
           self.label.text = "It was a short tap"
        }
        else{
            self.label.text = "It was a long tap"
        }
    }
}
