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

struct Defaults {
    
    static let TextFieldTitleLabelFontSize : CGFloat = 6.0
    static let TextFieldFontSize : CGFloat = 15.0
    static let FontFamilyItalics : String = "Helvetica-LightOblique"
    
}

enum FontType : String {
    case Default    = "Helvetica"
    case Bold       = "Helvetica-Bold"
    case Light      = "Helvetica-Light"
    case Italics    = "Helvetica-LightOblique"
}
extension UIFont {
    
    class var DefaultTextFieldFont : UIFont {
        get {
            if let fnt = UIFont(name: Globals.default_font_family, size: Defaults.TextFieldFontSize) {
                return fnt
            }
            
            return UIFont()
        }
    }
    
    class var DefaultFont : UIFont {
        get {
            if let fnt = UIFont(name: Globals.default_font_family, size: Globals.default_font_size) {
                return fnt
            }
            
            return UIFont()
        }
    }
    
    class var DefaultTitleLabelFont : UIFont {
        get {
            if let fnt = UIFont(name: Globals.default_font_family, size: Defaults.TextFieldTitleLabelFontSize) {
                return fnt
            }
            
            return UIFont()
        }
    }
    class var DefaultItalicsTitleLabelFont : UIFont {
        get {
            if let fnt = UIFont(name: Defaults.FontFamilyItalics, size: Defaults.TextFieldTitleLabelFontSize) {
                return fnt
            }
            
            return UIFont()
        }
    }
    
    class func FontWithType( fontType : FontType, size : CGFloat) -> UIFont {
        
        if let fnt = UIFont(name: fontType.rawValue, size: size) {
            return fnt
        }
        
        return UIFont()
    }
    
    class func DefaultFontWithSize( fontSize : CGFloat ) -> UIFont {
        
        if let fnt = UIFont(name: Globals.default_font_family, size: fontSize) {
            return fnt
        }
        
        return UIFont()
    }
}

