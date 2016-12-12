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



struct CurrencyValue {
    
    var total : Float {
        get {
            return (Float(intTotal) / 10.0)
        }
    }
    
    private var intTotal : Int = 0
    
    mutating func addValue( val : Int ) {
        intTotal *= 10
        intTotal += val
    }
    
    mutating func removeValue() {
        intTotal /= 10
    }
    
    func getCurrencyString() -> String {
        
        var currString = "$"
        
        var zeroCount = 0
        let maxZeroes = 4
        
        var intString = String(intTotal)
        let intCharCount = intString.characters.count
        
        zeroCount = maxZeroes - intCharCount
        
        if zeroCount < 0 { zeroCount = 0 }
        
        if zeroCount >= 1 {
        for _ in 1...zeroCount {
            currString.append("0")
        }
        }
        for _ in 1...intCharCount {
            currString.append(String(intString.characters.removeFirst()))
        }
        
        currString = currString.insert(string: ".", ind: currString.characters.count - 2)
        
        return currString
    }
    
    
    
    
}

extension String {
    
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
    mutating func cleanCurrencyString() {
        var cleanString = self.removeOccurrences(of: "$")
        cleanString = cleanString.removeOccurrences(of: ".")
        self = cleanString
    }
    
    mutating func pushCurrencyCharIn( char : Character ) {
        
        if char == "0" { return }
        if char == "." { return }
        
        self.cleanCurrencyString()
        self.removeLeadingZero()
        self.insert(char, at: self.endIndex)
    }
    
    mutating func recurrencifyString() {
        
    }
    mutating func removeLeadingZero() {
        
        if let first_char = self.characters.first {
            if first_char == "0" {
                self.removeFirstCharacter()
            }
        }
    }
    
    
    mutating func removeFirstCharacter() {
        
        if self.characters.count > 0 {
            self.remove(at: self.startIndex)
        }
        
    }
    func removeOccurrences(of str : String) -> String {
        return self.replacingOccurrences(of: str, with: "")
    }
}
