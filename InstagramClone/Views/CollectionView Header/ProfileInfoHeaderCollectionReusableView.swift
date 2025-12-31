//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 05/01/26.
//

import UIKit
protocol ProfileInfoHeaderCollectionReusableViewDelegate : AnyObject {
    func followingButtonTapped(_ header : ProfileInfoHeaderCollectionReusableView)
    func postsButtonTapped(_ header : ProfileInfoHeaderCollectionReusableView)
    func followersButtonTapped(_ header : ProfileInfoHeaderCollectionReusableView)
    func editProfileButtonTapped(_ header : ProfileInfoHeaderCollectionReusableView)
}
class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    weak var delegate : ProfileInfoHeaderCollectionReusableViewDelegate?
    private let profileImageSubview: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let postsButton : UIButton = {
       let btn = UIButton()
        btn.setTitle("Posts", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        return btn
    }()
    private let followersButton : UIButton = {
       let btn = UIButton()
        btn.setTitle("Follwers", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        return btn
    }()
    private let followingButton : UIButton = {
       let btn = UIButton()
        btn.setTitle("Following", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        return btn
    }()
    private let editProfileButton : UIButton = {
       let btn = UIButton()
        btn.setTitle("Edit Your Profile", for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8.0
        btn.setTitleColor(.label, for: .normal)
        return btn
    }()
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Shashank Gautam"
        label.numberOfLines = 1
        return label
    }()
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.text = "iOS Developer"
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        
        addButtonsAction()
        clipsToBounds = true
       
    }
    private func addSubViews(){
       addSubview(profileImageSubview)
    addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addButtonsAction(){
        followersButton.addTarget(self, action: #selector(didTapFollowerBtn), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingBtn), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileBtn), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostBtn), for: .touchUpInside)
    }
    
    
    // MARK - Actions
    /// all buttons implementations
    @objc private func didTapFollowerBtn(){
        print("Follower Button Tapped")
        delegate?.followersButtonTapped(self)
    }
    @objc private func didTapFollowingBtn(){
        print("Following Button Tapped")
        delegate?.followersButtonTapped(self)
    }
    @objc private func didTapPostBtn(){
        print("Post Button Tapped")
        delegate?.postsButtonTapped(self)
    }
    @objc private func didTapEditProfileBtn(){
        print("Edit Profile Button Tapped")
        delegate?.editProfileButtonTapped(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profileImageSize = width/4
        profileImageSubview.frame = CGRect(x: 5, y: 5, width: profileImageSize, height: profileImageSize)
        profileImageSubview.layer.cornerRadius = profileImageSize/2.0
        let btnHeight = profileImageSize/2.0
        let countBtnWidth = width - profileImageSize*3.2
        postsButton.frame = CGRect(x: profileImageSubview.right, y: 5, width: countBtnWidth, height: btnHeight)
        followersButton.frame = CGRect(x: postsButton.right, y:  5, width: countBtnWidth, height: btnHeight)
        
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countBtnWidth, height: btnHeight)
        
        editProfileButton.frame = CGRect(x: profileImageSubview.right + 10, y: followersButton.bottom + 5, width: countBtnWidth*3.0, height: btnHeight)
        
        nameLabel.frame = CGRect(x: 5, y: editProfileButton.bottom + 25, width: width - 10, height: 16)
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5, y: nameLabel.bottom + 6, width: width - 10, height: bioLabelSize.height)
    }
}
