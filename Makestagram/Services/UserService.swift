//
//  UserService.swift
//  Makestagram
//
//  Created by Alizandro Lopez on 7/11/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

//this service struct will act as an intermediary for communicating between the app and Firebase.
struct UserService {
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void){
        //create a dictionary to store the usernames, that the users provided, inside our database
        let userAttrs = ["username": username]
        
        //create a path for the location that we want to store the data
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        //write the data we want to store in the location that we specified above.
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error{
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            //we read the user we just wrote to the database and create a user from the snapshot. Now whenever an user is created, a user JSON object will also be created for them within our database
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show (forUID uid: String, completion: @escaping(User?) -> Void){
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else{
                return completion (nil)
            }
            completion(user)
        })
    }
}


