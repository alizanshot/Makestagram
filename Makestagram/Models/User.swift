//
//  User.swift
//  Makestagram
//
//  Created by Alizandro Lopez on 7/10/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDatabase

class User: Codable{
    let uid: String
    let username: String
    
    //1.Create a private static variable to hold our current user. This method is private so it can't be access outside of this class.
    private static var _current: User?
    
    //2.Create a computed variable that only has a getter that can access the private _current variable.
    static var current: User{
       //3.Check that _current that is of type User? isn't nil. If _current is nil, and current is being read, the guard statement will crash with fatalError().
        guard let currentUser = _current else{
            fatalError("Error: current user doesn't exist")
        }
        //4.If _current isn't nil, it will be returned to the user.
        return currentUser
    }
    
    //5.Create a custom setter method to set the current user
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            //turns object into data, this is not doable without Codable
            if let data = try? JSONEncoder().encode(user) {
                // write data
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        
        _current = user
    }
    
    init(uid:String, username:String) {
        self.uid = uid
        self.username = username
    }
    // if a user doesn't have a UID or a username, I fail the initialization and return nil.
    init?(snapshot: DataSnapshot){
        guard let dict = snapshot.value as? [String: Any],
            let username = dict["username"] as? String
            else {return nil}
        
        self.uid = snapshot.key
        self.username = username
        
    }
}
