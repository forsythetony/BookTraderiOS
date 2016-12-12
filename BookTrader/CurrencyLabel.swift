//
//  CurrencyLabel.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

class CurrencyLabel: UITextField, UITextFieldDelegate {

    private var keyboardIsUp = false
    
    private var currencyAmount : CurrencyValue = CurrencyValue()
    
    let numberFormatter : NumberFormatter = {
       
        let n = NumberFormatter()
        
        n.numberStyle = .currency
        
        return n
    }()
    
    var Value : Float {
        get {
            return currencyAmount.total
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.keyboardType = .numberPad
        self.text = self.currencyAmount.getCurrencyString()
        self.delegate = self
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(note:)), name: .UIKeyboardDidHide, object: nil)
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    func keyboardDidShow( notification : Notification) {
        
        if keyboardIsUp {
            return
        }
        
        keyboardIsUp = true
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        var oldFrame = self.superview?.frame
        
        oldFrame?.origin.y -= keyboardHeight
        
        UIView.animate(withDuration: TimeInterval(0.15)) {
            
            self.superview?.frame = oldFrame!
        }
        
        
    }
    
    func keyboardDidHide( note : Notification) {
        var oldFrame = self.superview?.frame
        
        oldFrame?.origin.y = 0.0
        
        UIView.animate(withDuration: TimeInterval(0.15)) {
            
            self.superview?.frame = oldFrame!
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.length != 1 {
            let intVal = Int(string)
            
            currencyAmount.addValue(val: intVal!)
        }
        else {
            currencyAmount.removeValue()
        }
        
        textField.text = currencyAmount.getCurrencyString()
 
        return false
    }
}
