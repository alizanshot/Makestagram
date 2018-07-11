//
//  User.swift
//  Makestagram
//
//  Created by Alizandro Lopez on 7/10/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDatabase

class User{
    let uid: String
    let username: String
    
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
