//
//  SignUpViewController.swift
//  xRate
//
//  Created by xianzhe yang on 15/2/18.
//  Copyright © 2018 hao. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func signupWithFirebase(_ sender: Any) {
        if checkNotNil(userName: userNameText.text!, email: emailText.text!, password: passwordText.text!) == true{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                if error == nil{
                    self.jumpToLogin()
                    print(user?.uid)
                }
            })
        }
        
        
    }
    
    func checkNotNil(userName:String,email:String,password:String) -> Bool {
        
        if userName != nil && email != nil && password != nil {
            return true
        }else {
            return false
        }
    }
    func jumpToLogin(){
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }

}
