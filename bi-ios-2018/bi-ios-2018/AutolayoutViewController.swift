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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
}
