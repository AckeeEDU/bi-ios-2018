//
//  ViewController.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 16.10.18.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fireButton: UIButton!
    weak var contentView: UIView!
    
    override func loadView() {
        super.loadView()
        
        let contentView = UIView(frame: view.bounds)
        view.insertSubview(contentView, belowSubview: fireButton)
        self.contentView = contentView
        
        let aView = UIView(frame: CGRect(x: 60, y: 150, width: 120, height: 200))
        aView.backgroundColor = UIColor(red: 0.72, green: 0.23, blue: 0.48, alpha: 1)
        aView.layer.cornerRadius = 20
        view.addSubview(aView)
        
        fireButton.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func fireButtonTapped(_ sender: UIButton) {
        print("Fire! \(random(min: 0, max: 1))")
        
        // Clear all old balls
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // repeat 20x
        for _ in 1...20 {
            
            // create random size & position
            let size = random(min: 0, max: view.bounds.width/2)
            let x = random(min: 0, max: view.bounds.width-size)
            let y = random(min: 0, max: view.bounds.height-size)
            
            // create random color channels
            let red = random(min: 0, max: 1)
            let green = random(min: 0, max: 1)
            let blue = random(min: 0, max: 1)
            
            // create new ball
            let aView = UIView(frame: CGRect(x: x, y: y, width: size, height: size))
            aView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
            aView.layer.cornerRadius = size/2
            contentView.addSubview(aView)
        }
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        let rand = CGFloat(arc4random()) / 0xFFFFFFFF
        return rand * (max - min) + min
    }
}

