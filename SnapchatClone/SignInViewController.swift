//
//  ViewController.swift
//  SnapchatClone
//
//  Created by JuanJ on 6/8/17.
//  Copyright © 2017 JJB. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func turnUpTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user,error ) in
            print("We tried to sign in")
            if error != nil {
                print("error found.. \(String(describing: error))")
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print("error found: \(error)")
                    } else {
                        print("Created user succesfully")
                        self.performSegue(withIdentifier: "SignInSegue", sender: nil)
                    }
         
                })
            } else {
                print("Signed in Succesfully")
                self.performSegue(withIdentifier: "SignInSegue", sender: nil)
            }
        }
    }
    
    
}

