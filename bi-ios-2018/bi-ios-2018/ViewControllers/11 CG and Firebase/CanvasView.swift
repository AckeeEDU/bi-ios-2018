//
//  CanvasView.swift
//  bi-ios-2018
//
//  Created by Jan Misar on 11/12/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

protocol CanvasViewDelegate: class {
    func canvasView(_ canvasView: CanvasView, didDrawPath path: DrawingPath)
}

class CanvasView: UIView {

    public weak var drawingRecognizer: UIPanGestureRecognizer!
    
    weak var delegate: CanvasViewDelegate?
    
    var paths: [DrawingPath] = []
    
    var currentPath: DrawingPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panChanged(_:)))
        gestureRecognizer.maximumNumberOfTouches = 1
        addGestureRecognizer(gestureRecognizer)
        drawingRecognizer = gestureRecognizer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func panChanged(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let point = gestureRecognizer.location(in: self)
        
        switch gestureRecognizer.state {
        case .began:
            let path = DrawingPath()
            path.points.append(point)
            
            paths.append(path)
            currentPath = path
            break
        case .changed:
            currentPath?.points.append(point)
            break
        case .cancelled, .ended, .failed:
            delegate?.canvasView(self, didDrawPath: currentPath!)
            currentPath = nil
        default:
            currentPath = nil
            break
        }
        setNeedsDisplay()
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        paths.forEach { path in
            CanvasView.draw(path: path, in: context)
        }
    }
    
    static func draw(path: DrawingPath, in context: CGContext) {
        
        context.setLineWidth(path.lineWidth)
        context.setStrokeColor(path.color.cgColor)
        
        context.beginPath()
        
        context.move(to: path.points.first!) // víme jistě, že tam první máme
        context.addLines(between: path.points)
        
        context.drawPath(using: .stroke)
    }
}
