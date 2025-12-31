//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//

import UIKit
import SafariServices
struct SettingCellModel{
    let title : String
    let handler : (() -> Void)
}
enum SettingUrlType {
    case terms,privacy,help
}
/// ViewController to show User Settings
final class SettingsViewController: UIViewController {
    private let tableview : UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    private var data = [[SettingCellModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        configureNavigationBar()
        view.backgroundColor = .systemBackground
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
//        tableview.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    private func configureNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCLose))
    }
    @objc private func didTapCLose(){
        dismiss(animated: true, completion: nil)
    }
    private func configureModels(){
        data.append([SettingCellModel(title: "Edit Profile"){ [weak self] in
            self?.didTappedEditProfile()
        },SettingCellModel(title: "Invite Friends"){ [weak self] in
            self?.didTapInviteFriends()
        },SettingCellModel(title: "Save Original Posts"){ [weak self] in
            self?.didTapSaveOriginalPost()
        }])
        
        data.append([SettingCellModel(title: "Terms of Use"){ [weak self] in
            self?.didTapOpenUrl(type: .terms)
        },SettingCellModel(title: "Privacy Policy"){ [weak self] in
            self?.didTapOpenUrl(type : .privacy)
        },SettingCellModel(title: "Help/Feedback"){ [weak self] in
            self?.didTapOpenUrl(type: .help)
        }])

        data.append([SettingCellModel(title: "Log Out"){ [weak self] in
            self?.didTapLogout()
        }])

    }
    private func didTapSaveOriginalPost(){
        
    }
    private func didTappedEditProfile(){
       let vc = EditProfileViewController()
//    vc.modalPresentationStyle = .fullScreen
        vc.title = "Edit Profile"
       let navVC = UINavigationController(rootViewController: vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func didTapInviteFriends() {
        // will show share sheet to invite friends
    }
    private func didTapOpenUrl(type : SettingUrlType)
    {
        var url : String = ""
       switch type {
       case .terms : url = "https://help.instagram.com/termsofuse"
       case .privacy : url = "https://help.instagram.com/196883487377501/"
       case .help : url = "https://help.instagram.com"
        }
        
        guard let url = URL(string: url) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    private func didTapLogout(){
        
            
            let aletSheet = UIAlertController(title: "Logging Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
            aletSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            aletSheet.addAction(UIAlertAction(title: "Yes", style: .destructive, handler : { _ in
                AuthManager.shared.logoutUser { isLogout in
                    DispatchQueue.main.async {
                        if isLogout{
                            print("The user is logged out")
                            let vc = LoginViewController()
                            //                self.dismiss(animated: true)
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc,animated: true){
                                
                                self.navigationController?.popToRootViewController(animated: false)
                                self.tabBarController?.selectedIndex = 0
                            }
                        } else {
                            print("The error occured while logging out")
                        }
                    }
                }
            }))
        
        present(aletSheet,animated: true)
            
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
}


extension SettingsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle user selection here
        data[indexPath.section][indexPath.row].handler()
        
    }
}
