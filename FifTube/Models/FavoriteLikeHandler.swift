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
    
    var command : String = "https://fema-dev.fifgroup.co.id/fema-video-service/api/m/comment/"
    
    func doFavorite(params: [String:Any], completion: @escaping (CommentModel)->Void) {
        //func deserialize(params: [String:Any]) -> [VideoItemModel]{
        
        let headers = [
            "X-Auth-Token" : FifTubeManager.sharedInstance.getToken(),
            "Content-Type" : headerEncoding
        ]
        
        
        Alamofire.request(command, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
            
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
                
                
                print (responseData.result.value!)
                
                let comment: CommentModel = CommentModel()
                
                comment.commentBy = params["commentBy"] as! String
                comment.commentDate = Date(timeIntervalSince1970: (params["commentDate"] as! Double) / 1000)
                comment.text = params["text"] as! String
                
                
                completion(comment)
            }
        }
        
    }
}
