//
//  NoNotificationView.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 09/01/26.
//

import UIKit

class NoNotificationView : UIView {
    private let noNotificationLabel : UILabel = {
        
        let label = UILabel()
        label.text = "No notifications yet"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    
    private let noNotificationImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bell"))
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
//        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noNotificationLabel)
        addSubview(noNotificationImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        noNotificationImageView.frame = CGRect(x: (width - 50)/2, y: 0, width: 50, height: 50).integral
        noNotificationLabel.frame = CGRect(x: 0, y: noNotificationImageView.bottom, width: width, height: height - 50).integral
    }
    
}
