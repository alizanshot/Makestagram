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
            assertionFailure("Error Signing in: \(error.localizedDescription)")
            return
        }
        
        //First check that the FIRUser returned from authentication is not nil
        guard let user = user
            else{return}
        
       //We construct a relative path to the reference of the user's information in our database.
        let userRef = Database.database().reference().child("users").child(user.uid)
        
       //Then we read the data from the path we created and pass an event closure to handle the data (snapshot) that is passed back from the database.
        userRef.observeSingleEvent(of: .value, with: {(snapshot) in
            //chekc if user info exists (in this case a dictionary), if it does we know if its a new or returning user.
            if let userDict = snapshot.value as? [String: Any]{
                print("user already exists \(userDict.debugDescription)")
            }else{
                print("New user!")
            }
            

        })
        
       
    }
    
}
