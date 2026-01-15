//
//  ViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//
import FirebaseAuth // to check either user is already logged in or not
import UIKit


struct FeedRenderViewModel {
    let header : PostRenderViewModel
    let post : PostRenderViewModel
    let action : PostRenderViewModel
    let comments : PostRenderViewModel
    
}
class HomeViewController: UIViewController {
    private var feedRenderModel = [FeedRenderViewModel]()
    private let feedTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedTableView)
        createMockModels()
        feedTableView.reloadData()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        // Do any additional setup after loading the view.
//        
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print("Fail to sign out")
//        }
    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Check Auth Status - if user is already signed In,then it is unnecessary so the login screen again and again, so we are using the logic here that we assuming user is already logged In if not then show login Screen.
        checkLoginStatus()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedTableView.frame = view.bounds
    }
    
    private func  createMockModels() {
        
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(postId: "\(x)", userName: "@itsme", commentText: "Omg this is so cool", profileImageUrl: URL(string: "https://www.google.com")!, creationDate: Date(), likes: []))
        }
        let user = Users(userName: "halley", bio: "", name: (first:" ", last: " "), birthDate: Date(), gender: .male, counts: Counts(followedBy: 1, follows: 2, post: 4), profilePhoto: URL(string: "https//www.google.com")!, joinDate: Date())
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
            owner: user
        )
        for _ in 0..<5 {
            let viewModel = FeedRenderViewModel(header: PostRenderViewModel(renderType: .header(proivder: user)), post: PostRenderViewModel(renderType: .primaryContent(provider: post)), action: PostRenderViewModel(renderType: .actions(provider: "click")), comments: PostRenderViewModel(renderType: .comments(provider: comments)))
            feedRenderModel.append(viewModel)
        }
        
    }
    private func checkLoginStatus() {
        if Auth.auth().currentUser == nil {
            // Show login Screen here
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false, completion: nil)
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModel.count * 4
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let x = section
//        let model : FeedRenderViewModel
//        if x == 0{
//            model = feedRenderModel[0]
//        }
//        else {
//            let position = x % 4 == 0 ? x/4 : (x - (x % 4)/4)
//            model = feedRenderModel[position]
//        }
//        
//        let subSection = x % 4
//        
//        if subSection == 0 {
//            //header
//            
//            return 1
//        }
//        else if subSection == 1 {
//            // post
//            
//            return 1
//        }
//        else if subSection == 2 {
//            // actions
//            
//            return 1
//        }
//        else if subSection == 3 {
//            // comments
//            
//            let commentModel = model.comments
//            switch commentModel.renderType {
//            case .comments(let provider): return provider.count > 2 ? 2 : provider.count
//            @unknown default : fatalError("Invalid case")
//                
//            default:
//                   return 1
//            }
//       
//        }
//    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let position = section / 4
        let model = feedRenderModel[position]
        let subSection = section % 4

        switch subSection {
        case 0: // header
            return 1
        case 1: // post
            return 1
        case 2: // actions
            return 1
        case 3: // comments
            switch model.comments.renderType {
            case .comments(let provider):
                return min(provider.count, 2)
            case .actions, .primaryContent, .header : return 0
            @unknown default:
                return 0
            }
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let position = indexPath.section / 4
        let model = feedRenderModel[position]
        let subSection =  indexPath.section % 4

        switch subSection {
        case 0: // header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath)
//                cell.backgroundColor = .systemBlue
                return cell
            case .primaryContent, .actions, .comments : return UITableViewCell()
            
            }
           
        case 1: // post
            
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath)
//                cell.backgroundColor = .systemRed
                return cell
            case .header, .actions, .comments : return UITableViewCell()
          
            }
           
        case 2: // actions
            let actionsModel = model.action
            switch actionsModel.renderType {
            case .actions(let action):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath)
//                cell.backgroundColor = .systemOrange
                return cell
            case .header, .primaryContent, .comments : return UITableViewCell()
           
            }
           
        case 3: // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,for: indexPath) as! IGFeedPostGeneralTableViewCell
//                cell.backgroundColor = .systemGreen
                return cell
            case .actions, .primaryContent, .header : return UITableViewCell()
              
            }
           
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        switch subSection {
        case 0 : return 70
        case 1 : return tableView.width
        case 2 : return 60
        case 3 : return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section % 4 == 3 {
            return UIView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section % 4 == 3 {
            return 70
        }
        return 0
    }
}
