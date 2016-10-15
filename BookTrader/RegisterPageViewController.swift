//
//  RegisterPageViewController.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

enum InputError : String {
    case NotAllFieldsFilled = "Not all the fields were filled"
    case PasswordsDontMatch = "The passwords do not match"
    case None = "There was no error"
}
class RegisterPageViewController: UIViewController {

    
    var userInfo = UserInfo()
    private let dataMan = DataCommunicator.sharedInstance
    
    
    @IBOutlet weak var MainScrollView: UIScrollView!
    @IBOutlet weak var FirstNameTextField: SpecialTextField!
    @IBOutlet weak var LastNameTextField: SpecialTextField!
    @IBOutlet weak var EmailTextField: SpecialTextField!
    @IBOutlet weak var ChooseSchoolTextField: SpecialTextField!
    
    @IBOutlet weak var UsernameTextField: SpecialTextField!
    @IBOutlet weak var PasswordTextField: SpecialTextField!
    @IBOutlet weak var PasswordConfirmTextField: SpecialTextField!
    @IBOutlet weak var DistanceSlider: UISlider!
    
    @IBOutlet weak var DistanceValue: UILabel!
    
    
    @IBOutlet weak var BirthDatePicker: UIDatePicker!
    private let textfield_title_label_font_size : CGFloat = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupViews()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadData() {
        userInfo.dateJoined = Date()
        userInfo.dateJoined = Date.DefaultBirthDate
        
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
        BirthDatePicker.addTarget(self, action: #selector(dateDidChange(sender:)), for: .valueChanged)
        
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
        
        
        DistanceSlider.maximumValue = 50.0
        DistanceSlider.minimumValue = 0.0
        DistanceSlider.value = 20.0
        DistanceSlider.addTarget(self, action: #selector(distSliderDidChange(sender:)), for: .valueChanged)
        
    }
    
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
    @IBAction func didTapCancelButton(_ sender: AnyObject) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func didTapSubmitButton(_ sender: AnyObject) {
        
        let checkResult = checkFields()
        if checkResult == .None {
            
            fillUserInfo()
            
            dataMan.registerUserWithInformation(info: userInfo, completion: { (status, error) in
                
                if status != nil {
                    print(status!)
                } else {
                    print("There was an error \(error)")
                }
            })
            
        } else {
            
            showAlertWithMessage(message: checkResult.rawValue)
        }
    }
    func showAlertWithMessage( message : String ) {
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let default_action = UIAlertAction(title: "Ok", style: .default) { (_) in
            print("hi")
        }
        
        alert.addAction(default_action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func distSliderDidChange( sender : UISlider ) {
        
        let slide_value = Int(sender.value)
        
        DistanceValue.text = String(slide_value) + " mi"
    }
    func dateDidChange( sender : UIDatePicker ) {
        
        userInfo.birthDate = sender.date
    }
    
    private func fillUserInfo() {
        
        userInfo.firstName = FirstNameTextField.Text
        userInfo.lastName = LastNameTextField.Text
        userInfo.password = PasswordTextField.Text
        userInfo.email = EmailTextField.Text
        
    }
    private func checkFields() -> InputError {
        
        
        guard !FirstNameTextField.isEmpty() else { return .NotAllFieldsFilled }
        
        guard !LastNameTextField.isEmpty() else { return .NotAllFieldsFilled }
        
        guard !EmailTextField.isEmpty() else { return .NotAllFieldsFilled }
        
        guard (!PasswordTextField.isEmpty() && !PasswordConfirmTextField.isEmpty()) else { return .NotAllFieldsFilled }
        
        guard (PasswordTextField.Text == PasswordConfirmTextField.Text) else { return .PasswordsDontMatch }
        
        return .None
    }

}
