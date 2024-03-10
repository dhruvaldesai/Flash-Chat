//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
//        let email = emailTextfield.text
//        let password = passwordTextfield
        //or biji rite ek line ma
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
                
                if let err = error{
                    print(err.localizedDescription)
                    self.errorLabel.text = error?.localizedDescription
                    self.errorLabel.textColor = .red
                    
                }
                else {
//                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    
                }
            }
            
        }
        
        
        
        
        
        
        
        
    }
    
}
