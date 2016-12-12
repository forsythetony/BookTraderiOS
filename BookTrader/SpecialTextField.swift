//
//  SpecialTextField.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class SpecialTextField: UIView {

    private var titleText       : String = ""
    private var placeHolderText : String = ""
    private var text            : String = ""
    var textColor       : Color = Color.white {
        didSet {
            self.mainTextField.textColor = textColor
        }
    }
    
    func setAttributedPlaceholder( color : Color, fnt : UIFont, str : String ) {
        
        let attributes = [ NSForegroundColorAttributeName : color, NSFontAttributeName : fnt]
        
        mainTextField.attributedPlaceholder = NSAttributedString(string: str, attributes: attributes)
    }
    private var handler : ((Void) -> Void)? = nil
    
    var IsEditable = true
    
    
    var TitleLabelFontSize : CGFloat = 5.0 {
        didSet {
            optionalTextLabel.font = UIFont.FontWithType(fontType: .Italics, size: TitleLabelFontSize)
        }
    }
    
    var IsSecureText = false {
        didSet {
            self.mainTextField.isSecureTextEntry = IsSecureText
        }
    }
    
    var IsOptional = false {
        didSet {
            if IsOptional {
                optionalTextLabel.alpha = 0.7
            }
            else {
                optionalTextLabel.alpha = 0.0
            }
        }
    }
    
    var TitleText : String {
        get {
            return titleText
        }
        set {
            titleText = newValue
            mainTitleLabel.text = titleText
        }
    }
    
    var Text : String {
        get {
            return text
        }
        set {
            text = newValue
            mainTextField.text = text
        }
    }
    
    var PlaceholderText : String {
        get {
            return placeHolderText
        }
        set {
            placeHolderText = newValue
            mainTextField.placeholder = placeHolderText
        }
    }
    
    
    private let mainTextField : UITextField = UITextField()
    private let mainTitleLabel : UILabel = UILabel()
    private let optionalTextLabel : UILabel = {
       
        let lbl = UILabel()
        
        lbl.alpha = 0.0
        lbl.textAlignment = .right
        lbl.font = UIFont.FontWithType(fontType: .Italics, size: 5.0)
        let optional_text = "(optional)"
        lbl.text = optional_text
        return lbl
    }()
    
    private let tapGestureRec : UITapGestureRecognizer = UITapGestureRecognizer()
    
    private let percent_title_label : CGFloat = 0.2
    
    func setTitleFont( font : UIFont ) {
        
        mainTitleLabel.numberOfLines = 1
        mainTitleLabel.adjustsFontSizeToFitWidth = true
        mainTitleLabel.font = font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    convenience init(frame: CGRect, title : String, text : String, placeholder : String) {
        self.init(frame: frame)
        
        self.TitleText = title
        self.PlaceholderText = placeholder
        self.Text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    
    private func setupViews() {
        
        //  Set up the title text label
        var title_rect = CGRect()
        
        title_rect.size.height = self.frame.size.height * percent_title_label
        title_rect.size.width = self.frame.size.width.divideInHalf()
        
        
        mainTitleLabel.frame = title_rect
        mainTitleLabel.backgroundColor = Color.clear
        self.addSubview(mainTitleLabel)
        
        
        //  Set up the optional text label
        var optional_rect = CGRect()
        
        optional_rect.size.width = self.frame.size.width.divideInHalf()
        optional_rect.size.height = title_rect.height
        optional_rect.origin.x = self.frame.size.width.divideInHalf()
        
        optionalTextLabel.frame = optional_rect
        optionalTextLabel.backgroundColor = Color.clear
        self.addSubview(optionalTextLabel)
        
        //  Set up the main field label
        
        var text_rect = CGRect()
        let text_x_offset : CGFloat = 0.0
        
        text_rect.size.width = self.frame.size.width - text_x_offset
        text_rect.size.height = self.frame.size.height - title_rect.height
        text_rect.origin.y = title_rect.height
        text_rect.origin.x = text_x_offset
        mainTextField.frame = text_rect
        
        var mainTextBackground = Color.black
        mainTextBackground = mainTextBackground.withAlphaComponent(0.5)
        mainTextField.backgroundColor = mainTextBackground
        mainTextField.layer.cornerRadius = 8.0
        mainTextField.textColor = textColor
        
        self.addSubview(mainTextField)
        
        self.tapGestureRec.addTarget(self, action: #selector(self.didTapGestureRecognizer))
        self.addGestureRecognizer(self.tapGestureRec)
        self.backgroundColor = Color.clear
        
    }
    
    
    func didTapGestureRecognizer( sender : UITapGestureRecognizer) {
        
        if !self.IsEditable {
            self.handler?()
        }
    }
    func enableGestureRecognizer( actionHandler : @escaping (Void) -> Void) {
        
        self.IsEditable = false
        self.mainTextField.isEnabled = false
        self.handler = actionHandler
    }
    
}

extension SpecialTextField {
    
    func isEmpty() -> Bool {
        return Text == ""
    }
    
    func textLength() -> Int {
        return Text.characters.count
    }
}

extension UITextField {
    
    
}
