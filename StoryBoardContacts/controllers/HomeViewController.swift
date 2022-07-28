//
//  HomeViewController.swift
//  StoryBoardContacts
//
//  Created by Avaz Mukhitdinov on 26/07/22.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var items: Array<Contacts> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        apiPostList()
    }


    
    // MARK: - Methods

    func resfreshTableView(posts: [Contacts]){
        self.items = posts
        self.tableView.reloadData()
    }
    
    
    func apiPostList(){
        showProgress()
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.hideProgress()
            switch response.result{
            case .success:
                let posts = try! JSONDecoder().decode([Contacts].self, from: response.data!)
                self.resfreshTableView(posts: posts)
            case let .failure(error):
                print(error)
          
            }
        })
    }
    
    func apiPostDelete(post: Contacts){
        showProgress()
        
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
                self.apiPostList()
            case let .failure(error):
                print(error)
          
            }
        })
    }
    
    func initViews() {
        tableView.dataSource = self
        tableView.delegate = self
        
        initNavs()
        
    }
    
    func initNavs() {
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Posts"
    }
    
    func callCreateViewcontroller(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(post: Contacts){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
        vc.editContact = post
    }
    
    
    // MARK: -- Actions
    
    @objc func leftTapped() {
        apiPostList()
    }
    
    @objc func rightTapped() {
        callCreateViewcontroller()
    }
    
    // MARK: -- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactsTableViewCell", owner: self, options: nil)?.first as! ContactsTableViewCell
        
        cell.nameLabel.text = item.name
        cell.phoneLabel.text = item.phone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])
        ])
    }
    
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])
        ])
    }
    
    
    
    // MARK: Contextual ACtions
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, post: Contacts)-> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Delete") { (action, swipeButtonView, completion) in
            print("Delete Here")
            
            completion(true)
            self.apiPostDelete(post: post)
        }
    }
    
    
    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath, post: Contacts)-> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("Complete Here")
            
            completion(true)
            self.callEditViewController(post: post)
        }
    }
    
}


