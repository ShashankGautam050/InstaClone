//
//  UserTableTableViewCell.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 09/01/26.
//

import UIKit


protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfolliowBtn(for user: UserRelationShip)
}

enum FollowState {
    case following, notFollowing
}

struct UserRelationShip {
    let userName : String
    let name : String
    let type : FollowState
}
class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier: String = "UserFollowTableViewCell"
    weak var delegeate: UserFollowTableViewCellDelegate?
    private var user : UserRelationShip?
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@joedoe"
        label.textColor = .secondaryLabel
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.text = "joe doe"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private let followBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Follow", for: .normal)
        
        button.backgroundColor = .link
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(followBtn)
        contentView.addSubview(nameLabel)
    }
   
    private func addActions(){
        followBtn.addTarget(self, action: #selector(handleFollowUnfollow), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func handleFollowUnfollow(){
        guard let user else {return}
        delegeate?.didTapFollowUnfolliowBtn(for: user)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        userNameLabel.text = nil
        nameLabel.text = nil
        followBtn.setTitle(nil, for: .normal)
        followBtn.backgroundColor = nil
        followBtn.layer.borderWidth = 0
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        let btnWidth = contentView.width > 500  ? 220.0 : contentView.width/3.0
        let lblHeight = contentView.height/2.0
        userImageView.layer.cornerRadius = userImageView.height/2.0
        followBtn.frame = CGRect(x: contentView.width - 5 - btnWidth,y: 5, width: btnWidth, height: contentView.height - 10 )
        
        nameLabel.frame = CGRect(x: userImageView.right + 15, y: 3, width: contentView.width - 3 - userImageView.width - btnWidth, height: lblHeight)
        userNameLabel.frame = CGRect(x: userImageView.right + 15, y: nameLabel.bottom - 2, width: contentView.width - 3 - userImageView.width - btnWidth, height: lblHeight)
    }
    
    public func configure(with user: UserRelationShip) {
        self.user = user
        nameLabel.text = user.name
        userNameLabel.text = user.userName
        switch user.type {
        case .following:
            followBtn.setTitle("Unfollow", for: .normal)
            followBtn.setTitleColor(.label, for: .normal)
            followBtn.layer.borderWidth = 1
            followBtn.backgroundColor = .systemBackground
            followBtn.layer.borderColor = UIColor.label.cgColor
        case .notFollowing:
            followBtn.setTitle("Follow", for: .normal)
            followBtn.setTitleColor(.white, for: .normal)
            followBtn.layer.borderWidth = 0
            followBtn.backgroundColor = .link
            followBtn.layer.borderColor = UIColor.label.cgColor
        }
    }
}
