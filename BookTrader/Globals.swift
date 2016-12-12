//
//  Globals.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/14/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Globals {
    
    static let sharedInstance = Globals()
    
    static let default_font_family  : String    = "Helvetica"
    static let default_font_size    : CGFloat   = CGFloat(15.0)
    
    
    
    
}

struct Defaults {
    static let TextFieldTitleLabelFontSize : CGFloat = 6.0
    static let TextFieldFontSize : CGFloat = 15.0
    static let FontFamilyItalics : String = "Helvetica-LightOblique"
    static let SchoolCoordinates : CLLocationCoordinate2D = {
        let c = CLLocationCoordinate2D(latitude: 38.9428008, longitude: -92.3273835)
        return c
    }()
}

enum FontType : String {
    case Default    = "Helvetica"
    case Bold       = "Helvetica-Bold"
    case Light      = "Helvetica-Light"
    case Italics    = "Helvetica-LightOblique"
}

struct Segues {
    
    static let LandingToRegister = "show_register_page"
    static let LandingToHome = "landing_to_home_page"
    static let HomeToAddListing = "add_listing_from_home"
    
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


extension MKCoordinateRegion {
    
    static func DefaultRegionWithCenter( coordinates : CLLocationCoordinate2D ) -> MKCoordinateRegion {
        
        var region = MKCoordinateRegion()
        let degreesSpan : CLLocationDegrees = 0.011
        
        region.center   = coordinates
        region.span     = MKCoordinateSpan(latitudeDelta: degreesSpan, longitudeDelta: degreesSpan)
        
        return region
    }
}

