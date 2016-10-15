//
//  Helpers.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/14/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

struct TextFieldAttributes {
    
    var placeholder = ""
    var text = ""
    var font = UIFont.DefaultFont
    var fontColor = Color.DefaultTextFieldFontColor
    var hideChars = false
}

extension UITextField {
    
    func setupWithAttributes( _ attribtues : TextFieldAttributes) {
        self.font = attribtues.font
        self.textColor = attribtues.fontColor
        self.placeholder = attribtues.placeholder
        self.text = attribtues.text
        self.isSecureTextEntry = attribtues.hideChars
    }
}

extension CGFloat {
    
    func divideInHalf() -> CGFloat {
        return (self / 2.0)
    }
}

extension Int {
    
    func convertToTimeInterval() -> TimeInterval {
        let total_seconds = self * 365 * 24 * 60 * 60
        
        return TimeInterval(total_seconds)
    }
}
extension Date {
    
    static var DefaultBirthDate : Date {
        get {
            let age : Int = 19
            
            let date = Date(timeInterval: -(age.convertToTimeInterval()), since: Date())

            return date
        }
    }
    
    static var MinDate : Date {
        get {
            let maxAge : Int = 100
            
            let date = Date(timeInterval: -(maxAge.convertToTimeInterval()), since: Date())
            
            return date
        }
    }
}
