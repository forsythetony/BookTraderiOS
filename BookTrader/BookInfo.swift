//
//  BookInfo.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/15/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation


struct BookInfo {
    
    private static let kISBN13 = "isbn13"
    private static let kISBN10 = "isbn10"
    private static let kTitle = "title"
    private static let kSummary = "summary"
    private static let kAuthorData = "author_data"
    private static let kAuthorName = "name"
    
    
    
    var isbn13 : String = ""
    var isbn10 : String = ""
    var title : String = ""
    var summary : String = ""
    var author : String = ""
    var foundInformation : Bool = false
    
    static func buildWithJSONArray( arr : NSDictionary ) -> BookInfo {
        
        var b = BookInfo()
        
        if arr["error"] != nil {
            
            return b
        }
        
        if let arr_data = arr.object(forKey: "data") as? NSArray {
            
            if arr_data.count > 0 {
                if let main_data = arr_data.firstObject as? NSDictionary {
                    if let isbn13_t = main_data.object(forKey: BookInfo.kISBN13) as? String {
                        b.isbn13 = isbn13_t
                    }
                    
                    if let isbn10_t = main_data.object(forKey: BookInfo.kISBN10) as? String {
                        b.isbn10 = isbn10_t
                    }
                    
                    if let title_t = main_data.object(forKey: BookInfo.kTitle) as? String {
                        b.foundInformation = true
                        b.title = title_t
                    }
                    
                    if let summary_t = main_data.object(forKey: BookInfo.kSummary) as? String {
                        b.summary = summary_t
                    }
                    
                    if let author_info_arr = main_data.object(forKey: BookInfo.kAuthorData) as? [NSDictionary] {
                        
                        if author_info_arr.count > 0 {
                            
                            let author_info_first = author_info_arr.first
                            
                            if let author_name_t = author_info_first?.object(forKey: BookInfo.kAuthorName) as? String {
                                b.author = author_name_t
                            }
                        }
                    }
                }
            }
            
        }
        return b
    }
}
