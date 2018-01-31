//
//  CommentDeserializer.swift
//  FifTube
//
//  Created by Poing on 1/31/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class CommentDeserializer {
    let headerEncoding : String = "application/json"
    
    var command : String = "https://fema-dev.fifgroup.co.id/fema-video-service/api/m/comment/inquiry/by"
    var imageLoadCount : Int = 0
    
    var containerView : UIView?
    
    init() {
        
    }
    
    
    func deserialize(params: [String:Any], completion: @escaping ([CommentModel], Int)->Void) {
        //func deserialize(params: [String:Any]) -> [VideoItemModel]{
        
        let headers = [
            "X-Auth-Token" : FifTubeManager.sharedInstance.getToken(),
            "Content-Type" : headerEncoding
        ]
        
        
        Alamofire.request(command, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
            
            
            if((responseData.result.value) != nil) {
                
                /*
                 if let requestBody = responseData.request?.httpBody {
                 do {
                 let jsonArray = try JSONSerialization.jsonObject(with: requestBody, options: [])
                 print("Array: \(jsonArray)")
                 }
                 catch {
                 print("Error: \(error)")
                 }
                 }
                 */
                
                let resultJSON = JSON(responseData.result.value!)
                
                //print (responseData.result.value!)
                
                var comments: [CommentModel] = []
                
                if let isOk = resultJSON["statusCode"].int {
                    if isOk == 0 {
                        //Load json to VideoItemModel
                        if let commentJSONList = resultJSON["dataList"].array {
                            if commentJSONList.count > 0 {
                                for i in 0 ... (commentJSONList.count - 1) {
                                    let item = CommentModel()
                                    item.id = commentJSONList[i]["id"].string!
                                    item.title = commentJSONList[i]["title"].string!
                                    item.text = commentJSONList[i]["text"].string!
                                    item.commentBy = commentJSONList[i]["commentBy"].string!
                                    item.commentDate = Date(timeIntervalSince1970: TimeInterval(commentJSONList[i]["commentDate"].double! / 1000))
                                    
                                    comments.append(item)
                                }
                                
                            }
                        }
                        
                        let totalCount = resultJSON["totalCount"].int!
                        
                        
                        
                        completion(comments, totalCount)
                        print("Comments JSON: \(resultJSON)")
                    }
                } else {
                    if let errCode = resultJSON["status"].int {
                        if let errMessage = resultJSON["message"].string {
                            print("Error getting comments. CODE (\(errCode)) : \(errMessage)")
                        }
                    }
                }
                
                
            }
        }
        
    }

    
    func deserializeFromMock() -> [CommentModel] {
        
        var itemList : [CommentModel] = []
        
        //Create 10 items for mock
        for _ in 0...9 {
            let comment = CommentModel()
            itemList.append(comment)
        }
        
        return itemList
        
    }
}
