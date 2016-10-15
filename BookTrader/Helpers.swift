//
//  Helpers.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/14/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation
import UIKit

class JSONBucket {
    
    var json_arr_data = [String : Any]()
    private let dateMan = DateManager.sharedInstance
    
    
    
    func addString( k : String , v : String? ) {
        
        if let v = v {
            json_arr_data[k] = v
        } else {
            json_arr_data[k] = v
        }
    }
    
    func addDate( k : String, v : Date?, type : DateType) {
        if let v = v {
            json_arr_data[k] = dateMan.convertDateToString(type: type, date: v)
        } else {
            json_arr_data[k] = ""
        }
    }
    
    func addInt( k : String, v : Int? ) {
        if let v = v {
            json_arr_data[k] = v
        } else {
            json_arr_data[k] = 0
        }
    }
    
    func addFloat( k : String, v : Float? ) {
        
        if let v = v {
            json_arr_data[k] = v
        } else {
            json_arr_data[k] = Float(0)
        }
    }
    
    func convertToJSONData() -> Data?
    {
        do {
            let d = try JSONSerialization.data(withJSONObject: json_arr_data, options: .init(rawValue: 0))
            return d
        } catch _ {
            return nil
        }
    }
    
}
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

