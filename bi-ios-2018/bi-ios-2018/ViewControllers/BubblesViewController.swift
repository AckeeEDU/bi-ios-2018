//
//  BubblesViewController.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 16.10.18.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

class BubblesViewController: UIViewController {

    @IBOutlet weak var fireButton: UIButton!
    weak var pushButton: UIButton!
    weak var presentButton: UIButton!
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
        
        let pushButton = UIButton()
        pushButton.setTitle("Push autolayout", for: .normal)
        pushButton.setTitleColor(.white, for: .normal)
        pushButton.backgroundColor = .black
        view.addSubview(pushButton)
        pushButton.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        self.pushButton = pushButton
        
        let presentButton = UIButton()
        presentButton.setTitle("Present autolayout", for: .normal)
        presentButton.setTitleColor(.white, for: .normal)
        presentButton.backgroundColor = .black
        view.addSubview(presentButton)
        presentButton.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.top.equalTo(pushButton.snp.bottom).offset(20)
        }
        self.presentButton = presentButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bubbles viewControler"
        
        pushButton.addTarget(self, action: #selector(pushButtonTapped(_:)), for: .touchUpInside)
        presentButton.addTarget(self, action: #selector(presentButtonTapped(_:)), for: .touchUpInside)
        
        print("BubblesViewController did load.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("BubblesViewController will appear.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("BubblesViewController did appear.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("BubblesViewController will disappear.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("BubblesViewController did disappear.")
    }
    
    @objc func pushButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AutolayoutViewController")
        
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func presentButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AutolayoutViewController")
        
        present(vc, animated: true)
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

