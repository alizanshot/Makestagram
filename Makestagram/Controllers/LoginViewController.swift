//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Alizandro Lopez on 7/10/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

//avoids namespace conflicts
typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        //Handing off the authentication process to firebase UI. ending with present(authView...)
        guard let authUI = FUIAuth.defaultAuthUI() else {return}
        //set the LoginViewController to be a delegat of authUI.
        authUI.delegate = self
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}
extension LoginViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?){
        if let error = error{
           // assertionFailure("Error Signing in: \(error.localizedDescription)")
            return
        }
        
        //First check that the FIRUser returned from authentication is not nil
        guard let user = user
            else{return}
        
        //We construct a relative path to the reference of the user's information in our database.
       // let userRef = Database.database().reference().child("users").child(user.uid)

        
        //reading data in the database. If user already exists, then print welcome back, otherwise direct the user to the "CreateUsername" screen. Also set rootViewController
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                // handle new user
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            
            }
        }
        
    }
    
}
