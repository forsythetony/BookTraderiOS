//
//  Globals.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/14/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

class Globals {
    
    static let sharedInstance = Globals()
    
    static let default_font_family  : String    = "Helvetica"
    static let default_font_size    : CGFloat   = CGFloat(15.0)
    
    
    
}


extension UIFont {
    
    static func DefaultTextFieldFont() -> UIFont {
        if let fnt = UIFont(name: Globals.default_font_family, size: Globals.default_font_size) {
            return fnt
        }
        
        return UIFont()
    }
    
    
}
