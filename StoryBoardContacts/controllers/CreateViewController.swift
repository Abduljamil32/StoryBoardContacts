//
//  CreateViewController.swift
//  StoryBoardContacts
//
//  Created by Avaz Mukhitdinov on 26/07/22.
//

import UIKit
import Alamofire

class CreateViewController: BaseViewController {

    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    func apiCreatePost(post: Contacts){
        showProgress()
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post), handler: { response in
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

   
    @IBAction func createTapped(_ sender: Any) {
        apiCreatePost(post: Contacts(name: nameText.text!, phone: phoneText.text!))
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}
