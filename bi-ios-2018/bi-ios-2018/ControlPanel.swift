//
//  ControlPanel.swift
//  bi-ios-2018
//
//  Created by Dominik Vesely on 06/11/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import Foundation
import UIKit

class ControlPanelView : UIView {
    
    
    weak var colorSegment : UISegmentedControl!
    weak var shapeSegment : UISegmentedControl!
    weak var sizeSlider : UISlider!
    weak var valuesLabel : UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        let colorSegment = UISegmentedControl(items: ["Red","Green","Blue"])
        colorSegment.selectedSegmentIndex = 0
        self.colorSegment = colorSegment
        let shapeSegment = UISegmentedControl(items: ["Circle","Square"])
        shapeSegment.selectedSegmentIndex = 0
        self.shapeSegment = shapeSegment
        let sizePicker = UISlider()
        sizePicker.minimumValue = 10
        sizePicker.maximumValue = 100
        sizePicker.value = 10
        self.sizeSlider = sizePicker
        
        let label = createLabel("Values")
        valuesLabel = label
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.addArrangedSubview(createHStack(views: createLabel("Color"), colorSegment))
        stack.addArrangedSubview(createHStack(views: createLabel("Shape"), shapeSegment))
        stack.addArrangedSubview(createHStack(views: createLabel("Size"), sizePicker))
        stack.addArrangedSubview(createHStack(views: label))
        addSubview(stack)
        stack.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        
    }
    
    
    func createHStack(views : UIView...) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }
    
    func createLabel(_ text : String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.snp.makeConstraints { (make) in
            make.width.equalTo(150)
        }
        return label
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    
}
