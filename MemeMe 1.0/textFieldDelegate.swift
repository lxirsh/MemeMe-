//
//  textFieldDelegate.swift
//  MemeMe 1.0
//
//  Created by Lance Hirsch on 10/16/15.
//  Copyright © 2015 Lance Hirsch. All rights reserved.
//

import Foundation
import UIKit

class textFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
