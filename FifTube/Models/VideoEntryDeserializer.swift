//
//  VideoEntryDeserializer.swift
//  FifTube
//
//  Created by Poing on 1/25/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON


class VideoEntryDeserializer {
    
    let headerEncoding : String = "application/x-www-form-urlencoded"
    
    var command : String = "https://fema-dev.fifgroup.co.id/fema-video-service/api/m/fiftube/"
    
    func deserialize(videoId: String, completion: @escaping (VideoPlayerEntryModel)->Void) {
        
        print ("videoId: \(videoId)")
        
        let headers = [
            "X-Auth-Token" : FifTubeManager.sharedInstance.getToken(),
            "Content-Type" : headerEncoding
        ]
        
        let commandUrl = URL(string: "\(command)\(videoId)")
    
        
        Alamofire.request(commandUrl!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
            
            
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
                
                print (responseData.result.value!)
                
                let entry: VideoPlayerEntryModel = VideoPlayerEntryModel()
                
                if let errCode = resultJSON["status"].int {
                    if let errMessage = resultJSON["message"].string {
                        print("Error getting videos. CODE (\(errCode)) : \(errMessage)")
                    }
                } else {

                    entry.id = resultJSON["id"].string!
                    entry.url = resultJSON["url"].string!
                    entry.thumbnailUrl = resultJSON["thumbnailUrl"].string!
                    entry.title = resultJSON["title"].string!
                    entry.totalLikes = resultJSON["totalLike"].int!
                    entry.totalViews = resultJSON["totalViewer"].int!
                    entry.description = resultJSON["description"].string!
                    entry.createdBy = resultJSON["createdBy"].string!
                    entry.createdDate = Date(timeIntervalSince1970: TimeInterval(resultJSON["createdDate"].double! / 1000))
                    entry.favorite = resultJSON["favourite"].bool!
                    entry.liked = resultJSON["liked"].bool!
                }
                
                completion(entry)
                
            }
        }

    }



   func deserializeFromMock() -> VideoPlayerEntryModel? {

        let videoPlayerEntry = VideoPlayerEntryModel()
        
        
        videoPlayerEntry.url = "https://youtu.be/VuuTavE58y4"
        videoPlayerEntry.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        var comments : [CommentModel] = []
        
        for _ in 0 ... 10 {
            let comment = CommentModel()
            comment.commentBy = "Muad'dib"
            comment.text = "I must not fear. Fear is the mind-killer. Fear is the little-death that brings total obliteration. I will face my fear. I will permit it to pass over me and through me. And when it has gone past I will turn the inner eye to see its path. Where the fear has gone there will be nothing. Only I will remain."
            comment.commentDate = Date()
            comments.append(comment)
        }
        
        videoPlayerEntry.commentList = comments
        
        return videoPlayerEntry
    }
}
