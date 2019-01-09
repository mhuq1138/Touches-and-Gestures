//
//  ViewController.swift
//  Dragging and Dynamic Animator 1
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dragView: UIView!
    
    var animator:UIDynamicAnimator!
    var attachment:UIAttachmentBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attachDrag = UIPanGestureRecognizer(target: self, action: #selector(attachViewDrag(_:)))
        self.dragView.addGestureRecognizer(attachDrag)
    }
    
    @objc func attachViewDrag(_ p: UIPanGestureRecognizer){
        guard let view = p.view else{
            return
        }
        switch p.state{
        case .began:
            self.animator = UIDynamicAnimator(referenceView: self.view)
            let location = p.location(ofTouch: 0, in: view)
            let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
            let offset = UIOffset.init(horizontal: location.x - center.x, vertical: location.y - center.y)
            let anchor = p.location(ofTouch: 0, in: self.view)
            let attachment = UIAttachmentBehavior(item: view, offsetFromCenter: offset, attachedToAnchor: anchor)
            self.animator.addBehavior(attachment)
            self.attachment = attachment
        case .changed:
            self.attachment.anchorPoint = p.location(ofTouch: 0, in: self.view)
        default:
            self.animator = nil
        }
        
    }
}


