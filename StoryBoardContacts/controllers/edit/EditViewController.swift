//
//  EditViewController.swift
//  StoryBoardContacts
//
//  Created by Avaz Mukhitdinov on 26/07/22.
//

import UIKit

class EditViewController: BaseViewController, EditView {
    
    var posts : Contacts = Contacts()
    var PostID: String = "1"
    var presenter: EditPresenter!
   
    @IBOutlet weak var nText: UITextField!
    @IBOutlet weak var pText: UITextField!
    
    var editContact: Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        title = "Edit Contact"
    }
    
    func initViews(){
        nText.text = editContact?.name
        pText.text = editContact?.phone
        
        presenter = EditPresenter()
        presenter.view = self
        presenter.controller = self
        
    }
    
    func apiPostEdit(post: [Contacts]) {
        self.hideProgress()
        if post != nil {
            self.posts = editContact!
        }
    }
    
    
    // MARK: - Navigation
    
    @IBAction func editTapped(_ sender: Any) {
        let post1 = Contacts(id: (editContact?.id!)!, name: nText.text!, phone: pText.text!)
        presenter?.apiEditPost(post: post1)
        
        dismiss(animated: true, completion: nil)
    }
}
