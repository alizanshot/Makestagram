//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Alizandro Lopez on 7/11/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //guard to check that a FIRUser is logged in and that the user has provided a username in the text field.
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else {return}
        
        //creating user and checking everything. Check UserService.swift
        UserService.create(firUser, username: username) {(user) in
            guard let _ = user else {return}
    
            
        //next step is to redirect users to mainstoryboard after making an account
            //create an instance of our main storyboard
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
            }
            
           
    
        
        }
    
    

    }
    


