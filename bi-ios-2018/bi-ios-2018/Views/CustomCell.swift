//
//  CustomCell.swift
//  bi-ios-2018
//
//  Created by Lukáš Hromadník on 20/11/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

final class CustomCell: UITableViewCell {
    
    static let reuseIdentifier = "CustomCell"
    
    var avatar: UIImage? {
        get { return avatarImageView.image }
        set { avatarImageView.image = newValue }
    }
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var message: String? {
        get { return messageLabel.text }
        set { messageLabel.text = newValue }
    }
    
    private weak var avatarImageView: UIImageView!
    private weak var titleLabel: UILabel!
    private weak var messageLabel: UILabel!
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components setup
    
    private func setup() {
        let avatarImageView = UIImageView()
        avatarImageView.backgroundColor = .gray
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.clipsToBounds = true
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 0))
            make.bottom.lessThanOrEqualToSuperview().inset(5)
            make.size.equalTo(30)
        }
        self.avatarImageView = avatarImageView
        
        let titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(15)
        }
        self.titleLabel = titleLabel
        
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().inset(5)
        }
        self.messageLabel = messageLabel
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // e.g. cancel the image request
    }

}
