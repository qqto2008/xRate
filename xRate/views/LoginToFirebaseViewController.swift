

import UIKit
import FirebaseAuth
class LoginToFirebaseViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func login(_ sender: Any) {
        if email.text! != nil && password.text! != nil {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                if error == nil{
                    print(user?.uid)
                    print(user?.email)
                    self.jumptoNextPage()
                }
            })
        }
    }
    
    func jumptoNextPage() -> Void {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }

    

}
