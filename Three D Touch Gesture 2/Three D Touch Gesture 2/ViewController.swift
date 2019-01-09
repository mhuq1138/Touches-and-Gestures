//
//  ViewController.swift
//  Three D Touch Gesture 2
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let pop = Notification.Name("pop")
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let circle = CircleView(frame:CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(circle)
        
        NotificationCenter.default.addObserver(forName: .pop, object:
        nil, queue: .main) {
            n in
            let minX = 120 as UInt32
            let minY = 150 as UInt32
            let maxX = UInt32(self.view.bounds.width) - 100
            let maxY = UInt32(self.view.bounds.height) - 150
            let randX = arc4random_uniform(maxX-minX) + minX
            let randY = arc4random_uniform(maxY-minY) + minY
            let circle = CircleView(frame:CGRect(x:CGFloat(randX),y:CGFloat(randY),width:100,height:100))
            self.view.addSubview(circle)
        }
    }
    
    
}
