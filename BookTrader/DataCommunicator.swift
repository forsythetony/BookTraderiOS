//
//  DataCommunicator.swift
//  BookTrader
//
//  Created by Tony Forsythe on 10/14/16.
//  Copyright © 2016 Tony Forsythe. All rights reserved.
//

import Foundation

class DataCommunicator {
    
    static let sharedInstance = DataCommunicator()
    
    private let domain = "http://ec2-54-200-32-159.us-west-2.compute.amazonaws.com/API/"
    private let books_domain = "http://isbndb.com/api/v2/json/V4I8CL76/book/"
    
    
    
    
    func getBookInfoForISBN( isbn : String, completion : @escaping (_ info : BookInfo?, _ err : String?) -> Void) {
        
        let url_string = books_domain + isbn
        
        var request = URLRequest(url: URL(string: url_string)!)
        request.httpMethod = "GET"
        
        print(url_string)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                completion(nil, "error")
                return
            }
            
            let dataString = String(data: data, encoding: .utf8)
            
            print(dataString)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let bookInfo = self.buildBookInfoFromData(data: data)
            
            if let bookInfo = bookInfo {
                completion(bookInfo, nil)
            }
            else {
                completion(nil, "Couldn't create the bookInfo")
            }
        }
        task.resume()
    }
    func registerUserWithInformation( info : UserInfo, completion : @escaping (_ response : String?, _ : String?) -> Void) {
        
        let url_string = domain + "register.php"
        var request = URLRequest(url: URL(string: url_string)!)
        request.httpMethod = "POST"
        
        guard let data_string = info.convertToJSON() else {
            print("Uh oh")
            return
        }
        
        print(data_string)
        
        request.httpBody = data_string.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                completion(nil, "error")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            completion("Success", nil)
        }
        task.resume()
    }
    
}

extension DataCommunicator {
    
    func buildBookInfoFromData( data : Data? ) -> BookInfo? {
        
        do {
            let json_arr = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
            return BookInfo.buildWithJSONArray(arr: json_arr!)
        } catch _ {
            return nil
        }
    }
}
