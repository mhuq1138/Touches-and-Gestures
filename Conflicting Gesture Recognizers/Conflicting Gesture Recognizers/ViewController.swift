//
//  ViewController.swift
//  Conflicting Gesture Recognizers
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tapView: UIView!
    
    var initialHeight:CGFloat = 0.0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initialHeight = self.tapView.bounds.size.height
        self.tapView.backgroundColor = .blue
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        self.tapView.addGestureRecognizer(doubleTap)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        singleTap.require(toFail: doubleTap)
        self.tapView.addGestureRecognizer(singleTap)
    }
    
    @objc func singleTap(_ t: UITapGestureRecognizer){
        guard let view = t.view else{
            return
        }
        if view.backgroundColor == UIColor.blue{
            view.backgroundColor = UIColor.red
        }
        else{
            view.backgroundColor = UIColor.blue
        }
        
    }
    
    @objc func doubleTap(_ t: UITapGestureRecognizer){
        guard let view = t.view else{
            return
        }
        if view.bounds.size.height == self.initialHeight{
            view.bounds.size.height += 100
        }
        else{
            view.bounds.size.height = self.initialHeight
        }
    }
}


