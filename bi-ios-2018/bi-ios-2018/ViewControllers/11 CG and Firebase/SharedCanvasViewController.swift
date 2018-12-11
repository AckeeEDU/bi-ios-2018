//
//  SharedCanvasViewController.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 11/12/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

class SharedCanvasViewController: UIViewController {

    weak var scrollView: UIScrollView!
    weak var canvasView: CanvasView!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.scrollView = scrollView
        
        let canvasView = CanvasView()
        scrollView.addSubview(canvasView)
        canvasView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalTo(1000)
        }
        self.canvasView = canvasView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.panGestureRecognizer.minimumNumberOfTouches = 2
        scrollView.panGestureRecognizer.require(toFail: canvasView.drawingRecognizer)
        // stačí jeden ze dvou těchto řádků, oba řeší kolizi dvou recognizerů jen různým způsobem
    }

}
