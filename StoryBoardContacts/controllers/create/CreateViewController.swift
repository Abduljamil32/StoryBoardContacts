//
//  CreateViewController.swift
//  StoryBoardContacts
//
//  Created by Avaz Mukhitdinov on 26/07/22.
//

import UIKit
import Alamofire

class CreateViewController: BaseViewController, CreateView {

    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    var presenter: CreatePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        title = "Create Contact"
    }

    func initViews(){
        
        presenter = CreatePresenter()
        presenter.CreateView = self
        presenter.controller = self
    }
    
   
    func onCreateContact(posts: [Contacts]) {}
    // MARK: - Navigation

   
    @IBAction func createTapped(_ sender: Any) {
        presenter?.apiPostCreate(post: Contacts(name: nameText.text!, phone: phoneText.text!))
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}
