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
                            print("Error getting comments. CODE (\(errCode)) : \(errMessage)")
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
                
                completion(false)
            } else {
                let resultJSON : JSON? = JSON(responseData.result.value!)
                
                if let json = resultJSON {
                    if let errCode = json["status"].int {
                        if let errMessage = json["message"].string {
                            print("Error getting comments. CODE (\(errCode)) : \(errMessage)")
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
                            print("Error getting comments. CODE (\(errCode)) : \(errMessage)")
                        }
                    }
                }
            }
        }
        
    }
}
