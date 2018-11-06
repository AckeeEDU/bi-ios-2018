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
    var viewModel  = ActionViewModel()

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
    
    func setupBindings() {
        controlPanel.colorSegment.addTarget(viewModel, action: #selector(viewModel.colorForControl(_:)), for: .valueChanged)
        controlPanel.shapeSegment.addTarget(viewModel, action: #selector(viewModel.shapeForControl(_:)), for: .valueChanged)
        controlPanel.sizeSlider.addTarget(viewModel, action: #selector(viewModel.sizeForControl(_:)), for: .valueChanged)
        
        viewModel.didUpdate = {
            self.controlPanel.valuesLabel.text = self.viewModel.overView
        }
        
    }
    
    @objc func placeGestureHandler(recognizer : UITapGestureRecognizer) {
        let location = recognizer.location(in: self.view)
        let shape = viewModel.createShape(position: location)
        shape.action = {
            self.viewModel.removeShape(shape: shape)
        }
        view.addSubview(shape)
        
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}
