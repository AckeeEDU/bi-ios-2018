//
//  ScrollViewController.swift
//  bi-ios-2018
//
//  Created by Lukáš Hromadník on 20/11/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit
import SnapKit

final class ScrollViewController: UIViewController {
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller lifecycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        let contentView = UIView()
//        contentView.backgroundColor = .blue
//        scrollView.addSubview(contentView)
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.size.equalTo(100)
//        }
        
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.spacing = 15
        contentView.layoutMargins = UIEdgeInsets(top: 45, left: 15, bottom: 30, right: 15)
        contentView.isLayoutMarginsRelativeArrangement = true
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        for i in 1...100 {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "[\(i)] Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a purus quis nibh euismod rhoncus eu vel mi. Donec ultrices."
            contentView.addArrangedSubview(label)
        }
    }
    
}
