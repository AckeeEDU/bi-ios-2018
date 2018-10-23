//
//  AutolayoutViewController.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 23.10.18.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit
import SnapKit

class AutolayoutViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func loadView() {
        super.loadView()
        
        // self.label is defined in Main.storyboard
        
        let greenView = UIView() // 👀 no frame here ☝️
        greenView.backgroundColor = .green
        let height = NSLayoutConstraint(item: greenView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        greenView.addConstraint(height)
        
        
        
        let redView = UIView()
        redView.backgroundColor = .red
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let redBlueStack = UIStackView(arrangedSubviews: [redView, blueView])
        redBlueStack.spacing = 10
        redBlueStack.distribution = .fillEqually
        redBlueStack.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        let originalImage = UIImage(named: "demonic")
        let flippedImage = UIImage(cgImage: originalImage!.cgImage!, scale: UIScreen.main.scale, orientation: .upMirrored)
        let leftDemonicView = UIImageView(image: flippedImage)
        
        let rightDemonicView = UIImageView(image: #imageLiteral(resourceName: "demonic.png"))
        rightDemonicView.setContentHuggingPriority(.required, for: .horizontal)
        
        let demonicsStack = UIStackView(arrangedSubviews: [leftDemonicView, rightDemonicView])
        
        let mainStack = UIStackView(arrangedSubviews: [label, greenView, redBlueStack, demonicsStack])
        mainStack.spacing = 15
        mainStack.axis = .vertical
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
}
