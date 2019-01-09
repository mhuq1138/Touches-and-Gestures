//
//  ViewController.swift
//  Gesture Recognizers
//
//  Created by Mazharul Huq on 1/8/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var singleTapLabel: UILabel!
    @IBOutlet var doubleTapLabel: UILabel!
    @IBOutlet var longPressView: UIView!
    @IBOutlet var multiGestureView: UIView!
    @IBOutlet var rotateView: UIView!
    
    var width:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.width = self.doubleTapLabel.bounds.size.width
        self.singleTapLabel.backgroundColor = .green
        self.longPressView.backgroundColor = .red
        self.loadGestureRecognizers()
    }
    
    func loadGestureRecognizers(){
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.singleTapResponse(_:)))
        singleTap.numberOfTapsRequired = 1
        self.singleTapLabel.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapResponse(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.doubleTapLabel.addGestureRecognizer(doubleTap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressResponse(_:)))
        //Minumum 1 second press reuired for long press
        longPress.minimumPressDuration = 1.0
        longPress.numberOfTouchesRequired = 1
        self.longPressView.addGestureRecognizer(longPress)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeResponse(_ :)))
        swipe.direction = .down
        //Swipe is applied in the main view.
        self.view.addGestureRecognizer(swipe)
        
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(rotateResponse(_ :)))
        self.rotateView.addGestureRecognizer(rotate)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchResponse(_:)))
        multiGestureView.addGestureRecognizer(pinch)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panResponse(_:)))
        multiGestureView.addGestureRecognizer(pan)
        
    }
    
    @objc func singleTapResponse(_ t: UITapGestureRecognizer){
        if let view = t.view{
            if view.backgroundColor == UIColor.green{
                view.backgroundColor = UIColor.cyan
            }
            else{
                view.backgroundColor = UIColor.green
            }
        }
    }
    
    @objc func doubleTapResponse(_ t: UITapGestureRecognizer){
        if let view = t.view{
            if view.bounds.size.width == self.width{
                view.bounds.size.width += 100
            }
            else{
                view.bounds.size.width = self.width
            }
        }
    }
    
    @objc func longPressResponse(_ t: UILongPressGestureRecognizer){
        if let view = t.view{
            if view.backgroundColor == UIColor.red{
                view.backgroundColor = UIColor.blue
            }
            else{
                view.backgroundColor = UIColor.red
            }
        }
    }
    
    @objc func swipeResponse(_ t: UISwipeGestureRecognizer){
        if self.multiGestureView.backgroundColor == UIColor.blue{
            self.multiGestureView.backgroundColor = UIColor.red
            self.multiGestureView.frame.origin.y += 50
        }
        else{
            self.multiGestureView.backgroundColor = UIColor.blue
            self.multiGestureView.frame.origin.y -= 50
        }
    }
    
    @objc func rotateResponse(_ t: UIRotationGestureRecognizer){
        if let view = t.view{
            view.transform = view.transform.rotated(by: t.rotation)
            t.rotation = 0
        }
    }
    
    
    @objc func pinchResponse(_ p:UIPinchGestureRecognizer){
        if let view = p.view{
            view.transform = view.transform.scaledBy(x: p.scale, y: p.scale)
            p.scale = 1
        }
    }
    
    @objc func panResponse(_ p:UIPanGestureRecognizer ){
        let translate = p.translation(in: self.view)
        if let view = p.view{
            view.center = CGPoint(x:view.center.x + translate.x,
                                  y:view.center.y + translate.y)
            p.setTranslation(CGPoint.zero, in: self.view)
        }
    }
}


