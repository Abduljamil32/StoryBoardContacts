import Foundation

protocol HomePresenterProtocol {
    func apiPostList()
    func apiPostDelete(post: Contacts)
}

class HomePresenter: HomePresenterProtocol {
    
    
    var homeView: HomeView!
    var controller: BaseViewController!
    
    func apiPostList(){
        controller?.showProgress()
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { [self] response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                let posts = try! JSONDecoder().decode([Contacts].self, from: response.data!)
                self.homeView.LoedContacts(post: posts)
            case let .failure(error):
                print(error)
                self.homeView.LoedContacts(post: [Contacts]())
            }
        })
    }
    
    func apiPostDelete(post: Contacts){
        controller?.showProgress()
        
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: { [self] response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
                self.homeView.DeleteContact(deleted: true)
            case let .failure(error):
                print(error)
                self.homeView.DeleteContact(deleted: false)
            }
        })
    }
    
    
}
