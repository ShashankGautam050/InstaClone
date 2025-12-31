//
//  IGFeedPostActionTableViewCell.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 04/01/26.
//

import UIKit

class IGFeedPostActionTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
    }

}
