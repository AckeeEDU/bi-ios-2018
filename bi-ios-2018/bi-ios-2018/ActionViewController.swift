//
//  ActionViewController.swift
//  bi-ios-2018
//
//  Created by Dominik Vesely on 31/10/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ActionViewController : UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var selectedColor : UIColor = .red
    
    weak var controlPanel : ControlPanelView!

    override func loadView() {
        super.loadView()
        
        let controlPanel = ControlPanelView()
        view.addSubview(controlPanel)
        controlPanel.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin)
            make.width.equalToSuperview()
        }
        self.controlPanel = controlPanel
        
        let placeGesture = UITapGestureRecognizer(target: self, action: #selector(placeGestureHandler(recognizer:)))
        view.addGestureRecognizer(placeGesture)
        
    }
    
    @objc func placeGestureHandler(recognizer : UITapGestureRecognizer) {
        let location = recognizer.location(in: self.view)
        let size = controlPanel.sizeSlider.value
        let rect = UIView(frame: CGRect(x: 0, y: 0, width: Double(size), height: Double(size)))
        rect.frame.origin = location
        rect.backgroundColor = .red
        
        view.addSubview(rect)
    
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
            case 1: selectedColor = .green
            case 2: selectedColor = .blue
            default: selectedColor = .red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
