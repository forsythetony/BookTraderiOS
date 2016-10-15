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
    
    func setupWithAttributes( attribtues : TextFieldAttributes) {
        self.font = attribtues.font
        self.textColor = attribtues.fontColor
        self.placeholder = attribtues.placeholder
        self.text = attribtues.text
        self.isSecureTextEntry = attribtues.hideChars
    }
}
