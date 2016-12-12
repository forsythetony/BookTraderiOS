//
//  ImageCaptureViewController.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
extension ZBarSymbolSet: Sequence {
    public func makeIterator() -> NSFastEnumerationIterator {
        return NSFastEnumerationIterator(self)
    }
}

class AddListingViewController: UIViewController, UITextFieldDelegate, ZBarReaderDelegate {
    var ZBarReader: ZBarReaderViewController?
    
    @IBOutlet weak var BookTitleTextField: SpecialTextField!
    @IBOutlet weak var BookAuthorTextField: SpecialTextField!
    
    @IBOutlet weak var ISBNTextField: SpecialTextField!
    
    @IBOutlet weak var SummaryTextView: UITextView!
    @IBOutlet weak var PriceTextField: CurrencyLabel!
    
    private let dataMan = DataCommunicator.sharedInstance
    
    private let textfield_title_label_font_size : CGFloat = 9.0
    private var keyboardIsUp = false
    
    public var info : BookInfo?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    private func setupViews() {
        
        setupTextField(field: BookTitleTextField, title: "Book Title", placeholder: "Enter Book Title", text: "")
        setupTextField(field: BookAuthorTextField, title: "Book Author", placeholder: "Enter Book Author", text: "")
        setupTextField(field: ISBNTextField, title: "ISBN", placeholder: "Enter ISBN", text: "")
        
    }
    @IBAction func scanAction(_ sender: AnyObject) {
        
        if (self.ZBarReader == nil) {
            self.ZBarReader = ZBarReaderViewController()
        }
        
        self.ZBarReader?.readerDelegate = self
        
        self.ZBarReader?.scanner.setSymbology(ZBAR_I25, config: ZBAR_CFG_ENABLE, to: 0)
        
        self.ZBarReader?.readerView.zoom = 1.0
        
        self.ZBarReader?.showsZBarControls = true
        
        present(self.ZBarReader!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // ADD: get the decode results
        
        
 let results: NSFastEnumeration = info[ZBarReaderControllerResults] as! NSFastEnumeration
        
        var symbolFound : ZBarSymbol?
        
        for symbol in results as! ZBarSymbolSet {
            symbolFound = symbol as? ZBarSymbol
            break
        }
        let resultString = symbolFound!.data
        print(resultString)
 
        ISBNTextField.Text = symbolFound!.data
        
        self.ZBarReader?.dismiss(animated: true, completion: nil)
        
        dataMan.getBookInfoForISBN(isbn: self.ISBNTextField.Text) { (info, err) in
            
            if let info = info {
                self.updateBookInfo(info_t: info)
            }
        }
    }
    
    @IBAction func testButton(_ sender: AnyObject) {
        
    }
    
    private func updateBookInfo( info_t : BookInfo ) {
        
        DispatchQueue.main.async {
            self.info = info_t
            
            if !info_t.foundInformation {
                self.showAlertWithMessage(message: "Couldn't retrieve information for that ISBN")
            }
            else {
                self.ISBNTextField.Text = info_t.isbn13
                self.BookAuthorTextField.Text = info_t.author
                self.BookTitleTextField.Text = info_t.title
                self.SummaryTextView.text = info_t.summary
            }
            
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if PriceTextField.isFirstResponder {
            PriceTextField.resignFirstResponder()
        }
        
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
    
}
