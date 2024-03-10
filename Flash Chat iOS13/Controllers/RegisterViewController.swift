//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    print(err.localizedDescription)
                    self.errorLabel.text = err.localizedDescription
                    self.errorLabel.textColor = .red
                }
                else {
                 //self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)

                }
            }
        }
    }
    
}
