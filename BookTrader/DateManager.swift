//
//  DateManager.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import UIKit

enum DateType : String {
    case API    = "yyyy-MM-dd"
    case Debug  = "yyyy.MM.dd G 'at' HH:mm:ss zzz"
}

class DateManager {

    static let sharedInstance = DateManager()
    
    private let dateFormatter : DateFormatter = {
       
        let dm = DateFormatter()
        
        dm.dateFormat = DateType.API.rawValue
        
        return dm
    }()
    
    
    func convertDateToString( type : DateType, date : Date ) -> String? {
        
        var dateString : String?
        
        switch type {
        case .API:
            dateFormatter.dateFormat = DateType.API.rawValue
            
        case .Debug:
            dateFormatter.dateFormat = DateType.Debug.rawValue
        
        }
        
        dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
