import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var contacts = [Contact]()
    
    func apiContactList(){
        isLoading = true
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                self.contacts = contacts
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func apiContactDelete(contact: Contact, handler: @escaping (Bool) -> Void){
        self.isLoading = true
        AFHttp.del(url: AFHttp.API_POST_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
}
