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
    
    func getReipes( callback: @escaping (([Recipe]) -> ()))  {
        Alamofire.request("https://cookbook.ack.ee/api/v1/recipes").responseJSON { response in
            if let data = response.data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let recipes = try jsonDecoder.decode([Recipe].self, from: data)
                    callback(recipes)
                    
                } catch {}
            }

        }
    }
    
    func getRecipe(id: String, callback: (Recipe) -> ()) {
        Alamofire.request("https://cookbook.ack.ee/api/v1/recipes/\(id)").responseJSON { response in
        }
    }

    
}

