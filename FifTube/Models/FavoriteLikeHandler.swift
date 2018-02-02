//
//  FavoriteLikeHandler.swift
//  FifTube
//
//  Created by Poing on 1/31/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FavoriteLikeHandler {
    let headerEncoding : String = "application/json"
    
    let faveCmd : String = "https://fema-dev.fifgroup.co.id/fema-video-service/api/m/fiftube/favourite/"
    let unfaveCmd : String = "https://fema-dev.fifgroup.co.id/fema-video-service/api/m/fiftube/favourite/delete/"
    let likeCmd : String = "https://fema-dev.fifgroup.co.id/fema-video-service/api/m/fiftube/like/"
    
    func doFavorite(videoId: String, completion: @escaping (Bool)->Void) {
        //func deserialize(params: [String:Any]) -> [VideoItemModel]{
        
        let headers = [
            "X-Auth-Token" : FifTubeManager.sharedInstance.getToken(),
            "Content-Type" : headerEncoding
        ]
        
        let command = "\(faveCmd)\(videoId)"
        
        Alamofire.request(command, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
            
            if let requestBody = responseData.request?.httpBody {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: requestBody, options: [])
                    print("Array: \(jsonArray)")
                }
                catch {
                    print("Error: \(error)")
                }
            }
            
            if((responseData.result.value) == nil) {
                
      
                
                completion(true)
            } else {
                let resultJSON : JSON? = JSON(responseData.result.value!)
                
                if let json = resultJSON {
                    if let errCode = json["status"].int {
                        if let errMessage = json["message"].string {
                            print("Error setting favorite. CODE (\(errCode)) : \(errMessage)")
                        }
                    }
                }
            }
        }
        
    }
    
    func doUnfavorite(videoId: String, completion: @escaping (Bool)->Void) {
        //func deserialize(params: [String:Any]) -> [VideoItemModel]{
        
        let headers = [
            "X-Auth-Token" : FifTubeManager.sharedInstance.getToken(),
            "Content-Type" : headerEncoding
        ]
        
        let command = "\(unfaveCmd)\(videoId)"
        
        Alamofire.request(command, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
            
            if let requestBody = responseData.request?.httpBody {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: requestBody, options: [])
                    print("Array: \(jsonArray)")
                }
                catch {
                    print("Error: \(error)")
                }
            }
            
            if((responseData.result.value) != nil) {
                
                let resultJSON = JSON(responseData.result.value!)
                //print("Unfave JSON: \(resultJSON)")
                
                if let isOk = resultJSON["statusCode"].int {
                    if isOk == 0 {
                        completion(false)
                    }
                } else {
                        if let errCode = resultJSON["status"].int {
                            if let errMessage = resultJSON["message"].string {
                                print("Error setting unfavorite. CODE (\(errCode)) : \(errMessage)")
                        }
                    }
                }
            }
        }
        
    }
    
    func doLike(videoId: String, completion: @escaping (Bool)->Void) {
        //func deserialize(params: [String:Any]) -> [VideoItemModel]{
        
        let headers = [
            "X-Auth-Token" : FifTubeManager.sharedInstance.getToken(),
            "Content-Type" : headerEncoding
        ]
        
        let command = "\(likeCmd)\(videoId)"
        
        Alamofire.request(command, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
            
            if let requestBody = responseData.request?.httpBody {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: requestBody, options: [])
                    print("Array: \(jsonArray)")
                }
                catch {
                    print("Error: \(error)")
                }
            }
            
            if((responseData.result.value) == nil) {
                
                completion(true)
            } else {
                let resultJSON : JSON? = JSON(responseData.result.value!)
                
                if let json = resultJSON {
                    if let errCode = json["status"].int {
                        if let errMessage = json["message"].string {
                            print("Error setting like. CODE (\(errCode)) : \(errMessage)")
                        }
                    }
                }
            }
        }
        
    }
}
