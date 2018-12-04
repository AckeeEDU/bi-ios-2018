//
//  DataManager.swift
//  bi-ios-2018
//
//  Created by Dominik Vesely on 04/12/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import Foundation
import Alamofire

class DataManager {
    
    func getReipes( callback: ((Any) -> ())?)  {
        Alamofire.request("https://cookbook.ack.ee/api/v1/recipes").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                callback?(json)
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
}

