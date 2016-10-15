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

class MyViewController: UIViewController, UITextFieldDelegate, ZBarReaderDelegate {
    var ZBarReader: ZBarReaderViewController?
    
    
    
    @IBOutlet weak var barCodeText: UITextField!
    
    @IBAction func scanAction(_ sender: AnyObject) {
        
        if (self.ZBarReader == nil) {
            self.ZBarReader = ZBarReaderViewController()
        }
        
        self.ZBarReader?.readerDelegate = self
        
        self.ZBarReader?.scanner.setSymbology(ZBAR_I25, config: ZBAR_CFG_ENABLE, to: 0)
        
        self.ZBarReader?.readerView.zoom = 1.0
        
        self.ZBarReader?.showsZBarControls = false
        
        present(self.ZBarReader!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: nil)
        
        self.barCodeText.delegate = self
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
 
        
    }
    
}
