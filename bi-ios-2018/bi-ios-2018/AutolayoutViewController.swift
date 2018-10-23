//
//  AutolayoutViewController.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 23.10.18.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

class AutolayoutViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func loadView() {
        super.loadView()
        
        // self.label is defined in Main.storyboard
        
        // Layout definition using basic NSLayoutConstraints
        let greenView = UIView() // 👀 no frame here ☝️
        greenView.backgroundColor = .green
        view.addSubview(greenView)
        
        greenView.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: greenView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        let trailing = NSLayoutConstraint(item: greenView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10)
        let top = NSLayoutConstraint(item: greenView, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 10)
        let height = NSLayoutConstraint(item: greenView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        view.addConstraints([leading, trailing, top])
        greenView.addConstraint(height)
        
        // other ways to create native constraints ➡️ https://useyourloaf.com/blog/pain-free-constraints-with-layout-anchors/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
}
