//
//  EditProfileViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//

import UIKit
struct EditProfileModel {
    let label : String
    let placeholder : String
    var value : String
    
}
class EditProfileViewController: UIViewController {
    private let tableView : UITableView = {
       let table = UITableView()
        table.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return table
    }()
    private var model = [[EditProfileModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel() 
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveBtn))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCancelBtn))
    }
    
    
    // MARK - private
    /// this method is responsible when user taps on the save button,it will save all the changes into the firebase datasouce that have been made.
    @objc func didTapSaveBtn() {
        
    }
    
    
    // MARK - private
    /// this is method is to show the basic profile of the user
    private func configureModel() {
        // name, username, website and bio
        let section1Labels = ["Name","Username","Bio"]
        var section1 = [EditProfileModel]()
        for label in section1Labels {
            let model = EditProfileModel(label: label, placeholder: "Enter the \(label)", value: "")
            section1.append(model)
        }
        model.append(section1)
        
        // email, phone , gender
        
        let section2Labels = ["Email","Phone","Gender"]
        var section2 : [EditProfileModel] = []
        for label in section2Labels {
            let model = EditProfileModel(label: label, placeholder: "Enter the \(label)", value: "")
            section2.append(model)
        }
        model.append(section2)  
    }
    @objc func didTapCancelBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/3).integral)
        let size = header.height/2.0
        let profileImageViewBtn = UIButton(frame: CGRect(x: (view.width - size)/2, y: (header.height - size)/2, width: size, height: size))
        header.addSubview(profileImageViewBtn)
        profileImageViewBtn.layer.masksToBounds = true
        profileImageViewBtn.tintColor = .label
        profileImageViewBtn.layer.cornerRadius = size/2
        profileImageViewBtn.addTarget(self, action: #selector(didTapOnProfile), for: .touchUpInside)
        profileImageViewBtn.setBackgroundImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        profileImageViewBtn.layer.borderWidth = 1
        profileImageViewBtn.layer.borderColor = UIColor.secondaryLabel.cgColor
        return header
    }
    @objc func didTapOnProfile() {
       print("User want to change the profile")
    }
    @objc func didTapProfilePicChange() {
        let alertSheet = UIAlertController(title: "Change Profile Picture", message: "Choose either from library or take a new one", preferredStyle: .actionSheet)
        alertSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        alertSheet.addAction(UIAlertAction(title: "Take a new one", style: .default, handler: { _ in
            
        }))
        alertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertSheet,animated : true)
    }
   
}

extension EditProfileViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.model[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier,for: indexPath) as! FormTableViewCell
        cell.configureModel(with: model)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Private Information"
        }
        return nil
    }
}

extension EditProfileViewController : FormTableViewCellDelegate {
    func didEndEditing(_ cell: FormTableViewCell, updatedModel: EditProfileModel?) {
        print(updatedModel?.value ?? "nil")
    }
    
    
}
