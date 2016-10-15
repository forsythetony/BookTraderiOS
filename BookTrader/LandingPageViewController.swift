//
//  LandingPageViewController.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/14/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

//  This is the first page of the application. Based on whether or not the user
//  is logged in it will either display content or prompt them to log in


class LandingPageViewController: UIViewController, LocationManagerDelegate {

    
    @IBOutlet weak var PasswordTextField: SpecialTextField!
    @IBOutlet weak var UsernameTextField: SpecialTextField!
    
    
    private let textfield_title_label_font_size : CGFloat = 6.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        let loc_man = LocationManager.sharedInstance
        loc_man.delegate = self
        
        if loc_man.canOperate {
            loc_man.beginLooking()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  MARK: Setup and Init
    private func setup() {
        
        self.title = "Login"
        
        //  Username TextField
       setupTextField(field: UsernameTextField, title: "Username", placeholder: "Enter Username", text: "", isEditable: true, isOptional: false, isSecureText: false, actionHandler: nil)
        
        //  Password Textfield
        setupTextField(field: PasswordTextField, title: "Password", placeholder: "Enter Password", text: "", isEditable: true, isOptional: false, isSecureText: true, actionHandler: nil)

    }
    
    
    //  MARK: Button Handlers
    @IBAction func didTapRegister(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: Segues.LandingToRegister, sender: nil)
    }
    @IBAction func didTapLogin(_ sender: AnyObject) {
        
        //  First check login
        
        self.performSegue(withIdentifier: Segues.LandingToHome, sender: nil)
    }
    
    //  MARK: Segue Preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segue_id = segue.identifier else {
            return
        }
        
        switch segue_id {
        case Segues.LandingToRegister:
            let dest = segue.destination as? RegisterPageViewController
            
            if let dest = dest {
                if self.UsernameTextField.Text != "" {
                    dest.userInfo.userName = self.UsernameTextField.Text
                }
            }
            
        case Segues.LandingToHome:
            let dest = segue.destination as? HomePageViewController
            
        default:
            
            print("Default")
            
        }
        
    }
    
    //  MARK: Delegate Functions
    func LocationManagerCanNowOperate(manager: LocationManager) {
        
        print("I can operate!")
        
        manager.beginLooking()
    }
    
    //  MARK: Utility Functions
    func setupTextField( field : SpecialTextField, title : String, placeholder : String, text : String, isEditable: Bool = true, isOptional : Bool = false, isSecureText : Bool = false, actionHandler : ((Void) -> Void)? = nil) {
        
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
    
}
