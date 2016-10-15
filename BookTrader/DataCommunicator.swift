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
