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
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as? IGFeedPostTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
