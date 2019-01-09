//
//  ViewController.swift
//  Hit Testing
//
//  Created by Mazharul Huq on 1/9/19.
//  Copyright © 2019 Mazharul Huq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tapLabel: UILabel!
    @IBOutlet var tapImageView: UIImageView!
    
    @IBOutlet var buttonTapLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tapLabel.backgroundColor = .blue
    }
    
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        let image1 = UIImage(named: "red_target")
        let image2 = UIImage(named: "green_target")
        let point = sender.location(ofTouch: 0, in: sender.view)
        let view = sender.view?.hitTest(point, with: nil)
        if let view = view as? UILabel{
            view.backgroundColor = view.backgroundColor == .blue ? .red: .blue
        }
        if let view = view as? UIImageView{
            view.image = view.image == image1 ? image2: image1
        }
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.buttonTapLabel.text = "Button tapped"
    }
}


