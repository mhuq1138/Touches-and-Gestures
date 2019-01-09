//
//  ViewController.swift
//  Subclassing Gesture Recognizers
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet var dragView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let horizontalDrag = HorizontalPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        self.dragView.addGestureRecognizer(horizontalDrag)
        
        let verticalDrag = VerticalPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        self.dragView.addGestureRecognizer(verticalDrag)
        
    }
    
    @objc func drag(_ p:UIPanGestureRecognizer){
        
        guard let view = p.view else{
            
            return
        }
        
        let translate = p.translation(in: view.superview)
        view.center = CGPoint(x: view.center.x + translate.x, y: view.center.y + translate.y)
        p.setTranslation(.zero, in: view.superview)
    }
    
    
}


