//
//  NotificationViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//

import UIKit

enum UserNotificationType {
    case like(post: PhotoPost)
    case follow(follow : FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: Users
}

final class NotificationViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(
            NotificationFollowEventTableViewCell.self,
            forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier
        )
        tableView.register(
            NotificationLikeTableViewCell.self,
            forCellReuseIdentifier: NotificationLikeTableViewCell.identifier
        )
        return tableView
    }()

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private lazy var noNotificationView = NoNotificationView()
    private var models = [UserNotification]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        view.addSubview(spinner)

        tableView.dataSource = self
        tableView.delegate = self

        spinner.startAnimating()
        fetchNotifications()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }

    // MARK: - Data
    private func fetchNotifications() {

        let post = PhotoPost(
            identifier: "",
            thumbnailImage: URL(string: "https://www.google.com")!,
            postUrl: URL(string: "https://www.google.com")!,
            caption: "Oh god",
            likesCount: [],
            comments: [],
            creationDate: Date(),
            photoType: .photo,
            taggedUsers: [],
            owner: Users(userName: "halley", bio: "", name: (first:" ", last: " "), birthDate: Date(), gender: .male, counts: Counts(followedBy: 1, follows: 2, post: 4), profilePhoto: URL(string: "https//www.google.com")!, joinDate: Date())
        )

        for x in 0...100 {
            let model = UserNotification(
                type: x % 2 == 0 ? .like(post: post) : .follow(follow: .notFollowing),
                text: "You got a message",
                user: Users(
                    userName: "halley",
                    bio: "",
                    name: (first: "Shashank", last: "Gautam"),
                    birthDate: Date(),
                    gender: .male,
                    counts: Counts(followedBy: 1, follows: 3, post: 1),
                    profilePhoto: URL(string: "https://www.google.com")!,
                    joinDate: Date()
                )
            )
            models.append(model)
        }

        spinner.stopAnimating()

        if models.isEmpty {
            addNoNotificationView()
        } else {
            tableView.isHidden = false
            tableView.reloadData()
        }
    }

    private func addNoNotificationView() {
        tableView.isHidden = true
        view.addSubview(noNotificationView)
        noNotificationView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width / 2,
            height: view.width / 4
        )
        noNotificationView.center = view.center
    }
}

// MARK: - TableView
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let model = models[indexPath.row]

        switch model.type {
        case .follow:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationFollowEventTableViewCell.identifier,
                for: indexPath
            ) as! NotificationFollowEventTableViewCell
//            cell.configure(with: model)
            cell.delegate = self
            return cell

        case .like:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationLikeTableViewCell.identifier,
                for: indexPath
            ) as! NotificationLikeTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
}


extension NotificationViewController : NotificationLikeTableViewCellDelegate {
    func didTapPostBtn(for model: UserNotification) {
        print("button tapped")
        switch model.type {
        case .follow(follow: _):
            fatalError("Dev : Issue with the model type")
        case .like(let post):
            let vc = PostViewController(model : post)
            navigationController?.pushViewController(vc, animated: true)
            vc.title = post.photoType.rawValue
        }
       
    }
    
    
}


extension NotificationViewController : NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowBtn(for model: UserNotification) {
        print("button tapped")
    }
    
    
}
