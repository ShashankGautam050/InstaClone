//
//  ProfileViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//

import UIKit
/// Profile VIew Controller
class ProfileViewController: UIViewController {
    private var collection : UICollectionView!
    private var userPost : [PhotoPost] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureNavbarItems()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let size = (view.width - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
       
       // Cell
        collection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifer)
        
        // Headers
        collection.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        collection.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        view.addSubview(collection)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collection?.frame = view.bounds
    }
    private func configureNavbarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapSetting))
    }
    @objc private func didTapSetting() {
        print("Tapped Setting Gear Icon")
        let vc = SettingsViewController()
           vc.title = "Settings"
           let nav = UINavigationController(rootViewController: vc)
           nav.modalPresentationStyle = .fullScreen

           present(nav, animated: true)
    }

}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
//         return userPost.count
        return 30
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifer, for: indexPath) as! PhotoCollectionViewCell
        guard let image = UIImage(named: "batman") else {return UICollectionViewCell()}
        cell.configure(with: "batman")
//        cell.backgroundColor = .systemBlue
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let model = userPost[indexPath.row]
//        let vc = PostViewController(model: model)
        let vc = PostViewController(model: nil)
        vc.title = "Post"
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.width, height: 200)
//    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {return UICollectionReusableView() }
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            header.delegate = self
            return header
        }
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
                header.delegate = self
            return header
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (view.width - 4)/3, height: (view.width - 4)/3)
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        } else {
            return CGSize(width: collectionView.width, height: 55)
        }
    }
}


extension ProfileViewController : ProfileInfoHeaderCollectionReusableViewDelegate {
    func followingButtonTapped(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationShip]()
        for x in 1...10 {
            mockData.append(UserRelationShip(userName: "@Joe Smith", name: "Joe Smith", type:  x % 2 == 0 ? .following : .notFollowing))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav,animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func postsButtonTapped(_ header: ProfileInfoHeaderCollectionReusableView) {
        collection.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func followersButtonTapped(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationShip]()
        for x in 1...10 {
            mockData.append(UserRelationShip(userName: "@Joe Smith", name: "Joe Smith", type:  x % 2 == 0 ? .following : .notFollowing))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Followers"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav,animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func editProfileButtonTapped(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav,animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension ProfileViewController : ProfileTabsCollectionReusableViewDelegate {
    func didSelectGridTab() {
        
    }
    
    func didSelectTaggedTab() {
        
    }
    
    
}
