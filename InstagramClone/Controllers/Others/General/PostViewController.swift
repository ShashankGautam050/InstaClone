//
//  PostViewController.swift
//  InstagramClone
//
//  Created by Shashank Gautam on 31/12/25.
//

import UIKit
/*
 Section
 - Header Model
 Section
 - Post Cell Model
 Section
 - Action Buttons Cell Model
 Section
 - n Numbers of General models for comments
 */

enum PostRenderType {
    case header(proivder : Users)
    case primaryContent(provider : PhotoPost)
    case actions(provider : String)
    case comments(provider : [PostComment])
}

struct PostRenderViewModel {
    let renderType : PostRenderType
}
class PostViewController: UIViewController {

    private var model : PhotoPost?
    private var renderModel = [PostRenderViewModel]()
    private let tableView : UITableView = {
       let tv = UITableView()
        // registers cells
        tv.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tv.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        tv.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tv.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        return tv
    }()
//    init(model : PhotoPost){
//        super.init(nibName: nil, bundle: nil)
//        self.model = model
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    
    init(model: PhotoPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels(){
        guard let model else {return}
        renderModel.append(.init(renderType: .header(proivder: model.owner)))
        renderModel.append(.init(renderType: .primaryContent(provider: model)))
        renderModel.append(.init(renderType: .actions(provider: "Like")))
        var comments : [PostComment] = []
        for x in 1...4 {
            comments.append(PostComment(postId: "12\(x)", userName: "@herd", commentText: "Thats awesome", profileImageUrl: URL(string : "https://randomuser.me/api/portraits/med/women/\(x).jpg")!, creationDate: Date(),likes : []))
        }
        renderModel.append(.init(renderType: .comments(provider: comments)))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}
extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        renderModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModel[section].renderType {
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primaryContent(provider: _): return 1
        case .header(proivder: _): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModel[indexPath.section]
        switch model.renderType {
        case .actions(provider: _):
            let cell : IGFeedPostActionTableViewCell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier,for: indexPath) as! IGFeedPostActionTableViewCell
            
                return cell
            
        case .comments(provider: let comments):
            let cell : IGFeedPostGeneralTableViewCell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
                    
            
        case .primaryContent(provider: let post):
            let cell : IGFeedPostTableViewCell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        case .header(proivder: _):
            let cell : IGFeedPostHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModel[indexPath.section]
        switch model.renderType {
        case .actions(provider: _): return 60
        case .comments(provider: let comments): return 50
        case .primaryContent(provider: let post): return tableView.width
        case .header(proivder: _): return 70
        }
    }
}
