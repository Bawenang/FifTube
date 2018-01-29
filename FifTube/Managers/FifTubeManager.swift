//
//  FifTubeManager.swift
//  FifTube
//
//  Created by Poing on 1/27/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FifTubeManager : NSObject {
    
    override init() {
        super.init()
        //login()
    }
    
    static let sharedInstance : FifTubeManager = FifTubeManager()
    
    let loginCommand : String = "https://fema-dev.fifgroup.co.id/login"
    
    var loginRes: JSON?
    
    let mockUsername : String = "OJT30"
    let mockPassword : String = "Passw0rdOJ"
    let headerEncoding : String = "application/x-www-form-urlencoded"

    
    func login(completion: @escaping ()->Void){
        let parameters  = [
            "username" : mockUsername,
            "password" : mockPassword
        ]
        
        let headers = [
            "Content-Type" : headerEncoding
        ]
        
        Alamofire.request(loginCommand, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                self.loginRes = JSON(responseData.result.value!)
                
                let token = self.loginRes!["token"]
                print ("token: \(token)")

            }
            
            completion()
        }

    }
    
    func getToken() -> String {
        return self.loginRes!["token"].string!
    }
    
    func getUsername() -> String {
        return self.loginRes!["username"].string!
    }
}
