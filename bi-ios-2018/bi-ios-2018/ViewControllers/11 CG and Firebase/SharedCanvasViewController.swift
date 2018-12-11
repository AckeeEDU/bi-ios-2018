//
//  SharedCanvasViewController.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 11/12/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CodableFirebase

class SharedCanvasViewController: UIViewController, CanvasViewDelegate {

    weak var scrollView: UIScrollView!
    weak var canvasView: CanvasView!
    
    private var databaseReference: DatabaseReference!
    
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
        
        databaseReference = Database.database().reference().child("canvas")
        
        canvasView.delegate = self
        
        scrollView.panGestureRecognizer.minimumNumberOfTouches = 2
        scrollView.panGestureRecognizer.require(toFail: canvasView.drawingRecognizer)
        // stačí jeden ze dvou těchto řádků, oba řeší kolizi dvou recognizerů jen různým způsobem
        
        databaseReference.observe(.childAdded) { [weak self] snapshot in
            guard let value = snapshot.value else { return }
            
            if let path = try? FirebaseDecoder().decode(DrawingPath.self, from: value) {
                self?.canvasView.add(path: path)
            }
        }
    }

    func canvasView(_ canvasView: CanvasView, didDrawPath path: DrawingPath) {
        
        let newPath = databaseReference.childByAutoId()
        path.key = newPath.key
        let data = try! FirebaseEncoder().encode(path)
        newPath.setValue(data) // completion, failure... chtělo by to ošetřit 🤔
    }
}
