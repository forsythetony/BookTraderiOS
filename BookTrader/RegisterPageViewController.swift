//
//  RegisterPageViewController.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var FirstNameTextField: SpecialTextField!
    @IBOutlet weak var LastNameTextField: SpecialTextField!
    @IBOutlet weak var EmailTextField: SpecialTextField!
    @IBOutlet weak var ChooseSchoolTextField: SpecialTextField!
    
    @IBOutlet weak var UsernameTextField: SpecialTextField!
    @IBOutlet weak var PasswordTextField: SpecialTextField!
    @IBOutlet weak var PasswordConfirmTextField: SpecialTextField!
    
    
    
    @IBOutlet weak var BirthDatePicker: UIDatePicker!
    private let textfield_title_label_font_size : CGFloat = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupViews() {
        
        
        setupTextField( field: FirstNameTextField,
                        title: "First Name",
                        placeholder: "Enter First Name",
                        text: "")
        
        setupTextField( field: LastNameTextField,
                        title: "Last Name",
                        placeholder: "Enter Last Name",
                        text: "",
                        isEditable: true,
                        isOptional: true,
                        isSecureText: false)
        
        
        setupTextField( field: EmailTextField,
                        title: "email",
                        placeholder: "Enter email",
                        text: "",
                        isEditable: true,
                        isOptional: false,
                        isSecureText: false)
        
        
        setupTextField( field: ChooseSchoolTextField,
                        title: "Choose School",
                        placeholder: "Choose School",
                        text: "No School Selected",
                        isEditable: false,
                        isOptional: false,
                        isSecureText: false,
                        actionHandler: {
            print("hi there")
        })
        
        
        BirthDatePicker.date = Date.DefaultBirthDate
        BirthDatePicker.minimumDate = Date.MinDate
        BirthDatePicker.maximumDate = Date()
        BirthDatePicker.datePickerMode = .date
        BirthDatePicker.tintColor = Color.orange
        
        
        setupTextField( field: UsernameTextField,
                        title: "Username",
                        placeholder: "Enter Username",
                        text: "")
        
        setupTextField( field: PasswordTextField,
                        title: "Password",
                        placeholder: "Enter Password",
                        text: "",
                        isEditable: true,
                        isOptional: false,
                        isSecureText: true)
        
        setupTextField( field: PasswordConfirmTextField,
                        title: "Confirm Password",
                        placeholder: "Re-Enter Password",
                        text: "",
                        isEditable: true,
                        isOptional: false,
                        isSecureText: true)
        
    }
    
    private func setupTextField( field : SpecialTextField, title : String, placeholder : String, text : String, isEditable: Bool = true, isOptional : Bool = false, isSecureText : Bool = false, actionHandler : ((Void) -> Void)? = nil) {
        
        let titleLabelFont = UIFont.FontWithType(fontType: .Bold, size: textfield_title_label_font_size)
        
        
        field.TitleText = title
        field.Text = text
        field.PlaceholderText = placeholder
        field.IsEditable = isEditable
        field.IsSecureText = isSecureText
        field.IsOptional = isOptional
        field.TitleLabelFontSize = textfield_title_label_font_size
        field.setTitleFont(font: titleLabelFont)
        
        if !isEditable {
            field.enableGestureRecognizer(actionHandler: actionHandler!)
        }
    }
    @IBAction func didTapCancelButton(_ sender: AnyObject) {
    }
    @IBOutlet weak var didTapSubmitButton: UIButton!

}
