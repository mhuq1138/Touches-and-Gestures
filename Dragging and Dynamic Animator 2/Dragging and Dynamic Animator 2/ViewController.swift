//
//  ViewController.swift
//  Dragging and Dynamic Animator 2
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var dragView: UIView!
    
    var animator:UIDynamicAnimator!
    var attachment: UIAttachmentBehavior!
    var slideAttachment: UIAttachmentBehavior!
    var origCenter:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let snap = UIPanGestureRecognizer(target: self, action: #selector(snapDrag(_:)))
        self.dragView.addGestureRecognizer(snap)
    }
    
    @objc func snapDrag(_ p: UIPanGestureRecognizer){
        
        switch p.state {
        case .began:
            self.origCenter = self.dragView.center
            self.animator = UIDynamicAnimator(referenceView: self.view)
            let slide = UIAttachmentBehavior.slidingAttachment(with:self.dragView, attachmentAnchor: CGPoint(x:self.view.bounds.midX, y:self.view.bounds.maxY), axisOfTranslation: CGVector(dx: 0, dy: 1))
            slide.attachmentRange = UIFloatRange(minimum: 0, maximum: 10000)
            self.animator.addBehavior(slide)
            self.slideAttachment = slide
            
            // initial touch point
            let pt = p.location(ofTouch:0, in:self.view)
            
            // attach center of red view to anchor at touch point
            let attachment = UIAttachmentBehavior(item: self.dragView,
                                                  offsetFromCenter: UIOffset(horizontal: 0, vertical: 10000),
                                                  attachedToAnchor: pt)
            self.animator.addBehavior(attachment)
            self.attachment = attachment
            
        case .changed:
            let pt = p.location(ofTouch:0, in:self.view)
            // move anchor to follow touch
            if pt.y > self.dragView.bounds.height/2 { // impose arbitrary limit
                self.attachment.anchorPoint = pt
            }
            
        case .ended:
            // user has let go! release red view
            self.animator.removeBehavior(self.attachment)
            
            // make a "cushion" at the floor
            let coll = UICollisionBehavior(items: [self.dragView])
            coll.setTranslatesReferenceBoundsIntoBoundary(with:
                UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1))
            self.animator.addBehavior(coll)
            
            let snap = UISnapBehavior(item: self.dragView, snapTo: self.origCenter)
            snap.damping = 0.3
            self.animator.addBehavior(snap)
        default:break
        }
    }
}



