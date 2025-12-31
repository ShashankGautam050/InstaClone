//
//  ListViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//

import UIKit

class ListViewController: UIViewController {
    
    
    private var data : [UserRelationShip] = []
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    init(data : [UserRelationShip]){
        super.init(nibName: nil, bundle: nil)
        self.data = data
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func addNavigationBarBtn() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeBtnTapped))
//    }
//   
//    @objc private func closeBtnTapped() {
//        navigationController?.popViewController(animated: true)
//    }
}


extension ListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell
       
        cell.configure(with: data[indexPath.row])
        cell.delegeate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController : UserFollowTableViewCellDelegate{
    func didTapFollowUnfolliowBtn(for user: UserRelationShip) {
        switch user.type {
            case .following:
            break
//            user.type = .notFollowing
        case .notFollowing:
            break
//            user.type = .following
        }
    }
    
    
}
