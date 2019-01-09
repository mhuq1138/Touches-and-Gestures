//
//  ViewController.swift
//  Gesture Recognizer in Nib
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tappableLabel: UILabel!
    @IBOutlet var dragableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        if let view = sender.view{
            if view.backgroundColor == UIColor.red{
                view.backgroundColor = UIColor.blue
            }
            else{
                view.backgroundColor = UIColor.red
            }
        }
    }
    
    @IBAction func dragGesture(_ sender: UIPanGestureRecognizer) {
        let translate = sender.translation(in: self.view)
        if let view = sender.view{
            view.center = CGPoint(x:view.center.x + translate.x,
                                  y:view.center.y + translate.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
}

