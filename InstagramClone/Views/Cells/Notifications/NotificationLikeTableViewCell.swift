//
//  NotificationLikeTableViewCell.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 10/01/26.
//

import UIKit
import SDWebImage

protocol NotificationLikeTableViewCellDelegate: AnyObject {
    func didTapPostBtn(for model : UserNotification)
}
class NotificationLikeTableViewCell: UITableViewCell {
    static let identifier : String = "NotificationLikeTableViewCell"
    
    public weak var delegate: NotificationLikeTableViewCellDelegate?
    private var model : UserNotification?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(userProfileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(postBtn)
        postBtn.addTarget(self, action: #selector(didTapPostBtn), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc private func didTapPostBtn(){
        guard let model = model else {return }
        delegate?.didTapPostBtn(for: model)
    }
    
    private let userProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.image = UIImage(named: "batman")
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .label
        label .numberOfLines = 1
        label.text = "Shashank Gautam liked your post"
        return label
    }()
    
    private let postBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Follow", for: .normal)
        btn.setBackgroundImage(UIImage(named: "batman"), for: .normal)
        return btn
     }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model : UserNotification) {
        self.model = model
        
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postBtn.sd_setBackgroundImage(with: thumbnail, for: .normal,completed: nil)
        case .follow:
            break
        }
        
        nameLabel.text = model.text
        userProfileImageView.sd_setImage(with: model.user.profilePhoto,completed: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        userProfileImageView.image = nil
        nameLabel.text = nil
        postBtn.setBackgroundImage(nil, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // photo, text and post button
        
        userProfileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        userProfileImageView.layer.cornerRadius = contentView.height / 2
        let size = contentView.height - 6
        postBtn.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        nameLabel.frame = CGRect(x: userProfileImageView.right + 10, y: 2, width: contentView.width - postBtn.width - size - 6, height: contentView.height)
    }
}

