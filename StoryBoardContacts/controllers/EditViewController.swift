//
//  EditViewController.swift
//  StoryBoardContacts
//
//  Created by Avaz Mukhitdinov on 26/07/22.
//

import UIKit

class EditViewController: BaseViewController {

    
    @IBOutlet weak var nText: UITextField!
    
    @IBOutlet weak var pText: UITextField!
    
    var editContact: Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       initViews()
    }
    
    func initViews(){
        nText.text = editContact?.name
        pText.text = editContact?.phone
    }


    func apiEditPost(post: Contacts){
        showProgress()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + post.id!, params: AFHttp.paramsPostUpdate(post: post), handler: { response in
            self.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
                
            case let .failure(error):
                print(error)
            }
        })
    }
    
    // MARK: - Navigation

    @IBAction func editTapped(_ sender: Any) {
        apiEditPost(post: Contacts(id: (editContact?.id!)!, name: nText.text!, phone: pText.text!))
    }
}
