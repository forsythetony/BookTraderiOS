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

class LandingPageViewController: UIViewController {

    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  Setup Methods
    private func setup() {
        
        //  Username TextField
        var username_textfield_attr = TextFieldAttributes()
        
        UsernameTextField.setupWithAttributes(attribtues: username_textfield_attr)
        
        //  Password Textfield
        var password_textfield_attr = TextFieldAttributes()
        password_textfield_attr.hideChars = true
        
        PasswordTextField.setupWithAttributes(attribtues: password_textfield_attr)
        
        
        
        
        
        
    }
    @IBAction func didTapRegister(_ sender: AnyObject) {
    }
    @IBAction func didTapLogin(_ sender: AnyObject) {
    }
}
