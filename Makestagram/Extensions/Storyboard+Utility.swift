//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by Alizandro Lopez on 7/11/18.
//  Copyright © 2018 Ali. All rights reserved.
//

import Foundation
import UIKit

//whole purpose is to identify any storyboard to avoid mis-typing
//or namespace conflicts
extension UIStoryboard{
    enum MGType: String{
        case main
        case login
        
        var filename: String{
            return rawValue.capitalized
        }
    }
    convenience init(type: MGType, bundle: Bundle? = nil){
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: MGType) -> UIViewController{
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial viewcontroller for  \(type.filename) storyboard.")
        }
        return initialViewController
    }
    
}
