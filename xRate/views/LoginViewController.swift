

import UIKit
//import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var clipView: UIView!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        clipView.layer.cornerRadius = 8
    }
    
    @IBAction func loginToFirebase(_ sender: Any) {
//        if emailText.text! != nil && passwordText.text != nil {
//            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
//                if error == nil{
//                    print(user?.uid ?? "error")
//                    print(user?.email ?? "error")
//                }
//            })
//        }

    }
    
    
    
}
