//
//  NotificationFollowEventTableViewCell.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 10/01/26.
//

import UIKit
import SDWebImage
protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowBtn(for model : UserNotification)
}
class NotificationFollowEventTableViewCell: UITableViewCell {
    static let identifier : String = "NotificationFollowEventTableViewCell"
    
    public weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model : UserNotification?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(userProfileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(followBtn)
        followBtn.addTarget(self, action: #selector(didTapFollowUnfollowBtn), for: .touchUpInside)
        configureFollwoBtn()
        selectionStyle = .none
    }
    @objc private func didTapFollowUnfollowBtn(){
        guard let model else {return}
        delegate?.didTapFollowUnfollowBtn(for: model)
    }
    
    private let userProfileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "batman")
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Shashank Gautam started following you."
        return label
    }()
    
    private let followBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Follow", for: .normal)
        btn.layer.masksToBounds = true
        return btn
     }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureFollwoBtn(){
        followBtn.setTitle("UnFollow", for: .normal)
        followBtn.setTitleColor(.label, for: .normal)
        followBtn.layer.borderWidth = 1
        followBtn.layer.cornerRadius = 16
        followBtn.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    public func configure(with model : UserNotification) {
        self.model = model
        
        switch model.type {
        case .follow(let state):
            switch state {
            case .following:
                    configureFollwoBtn()
            case .notFollowing:
                followBtn.setTitle("Follow", for: .normal)
                followBtn.setTitleColor(.label, for: .normal)
                followBtn.layer.borderWidth = 0
                followBtn.layer.cornerRadius = 16
//                followBtn.layer.borderColor = UIColor.secondaryLabel.cgColor
                followBtn.backgroundColor = .link
            }
        case .like(post: ):
            break
        }
        nameLabel.text = model.text
        userProfileImageView.sd_setImage(with: model.user.profilePhoto,completed: nil)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        userProfileImageView.image = nil
        nameLabel.text = nil
        followBtn.backgroundColor = nil
        followBtn.layer.borderWidth = 0
        followBtn.setTitle(nil, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userProfileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        userProfileImageView.layer.cornerRadius = contentView.height / 2
        let size : CGFloat = 100
        followBtn.frame = CGRect(x: contentView.width - size, y: (contentView.height - 44)/2, width: size, height: 44)
//        followBtn.backgroundColor = .brown
        nameLabel.frame = CGRect(x: userProfileImageView.right + 10, y: 2, width: contentView.width - followBtn.width - size - 6, height: contentView.height)
    }
}


