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
            @unknown default:
                return 0
            }
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as? IGFeedPostTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
