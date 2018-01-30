//
//  BaseVideoItemDeserializer.swift
//  FifTube
//
//  Created by Poing on 1/21/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class BaseVideoItemDeserializer {
    let headerEncoding : String = "application/json"
    
    var command : String = ""
    var imageLoadCount : Int = 0
    
    var containerView : UIView?
    
    init() {

    }
    

    func deserialize(params: [String:Any], completion: @escaping ([VideoItemModel], Int)->Void) {
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
                
                var videoItemList: [VideoItemModel] = []
                
                if let isOk = resultJSON["statusCode"].int {
                    if isOk == 0 {
                        //Load json to VideoItemModel
                        if let videoList = resultJSON["dataList"].array {
                            if videoList.count > 0 {
                                for i in 0 ... (videoList.count - 1) {
                                    let item = VideoItemModel()
                                    item.id = videoList[i]["id"].string!
                                    item.thumbnailUrl = videoList[i]["thumbnailUrl"].string!
                                    item.title = videoList[i]["title"].string!
                                    item.totalViews = videoList[i]["totalViewer"].int!
                                    item.createdBy = videoList[i]["createdBy"].string!
                                    item.createdDate = Date(timeIntervalSince1970: TimeInterval(videoList[i]["createdDate"].double! / 1000))
                                    
                                    videoItemList.append(item)
                                }
                                
                            }
                        }
                        
                        let totalCount = resultJSON["totalCount"].int!
                        
                        completion(videoItemList, totalCount)
                        
                        //Load Images
                        if let videoList = resultJSON["dataList"].array {
                            if videoList.count > 0 {
                                self.loadImages(videoItemList: videoItemList)
                            }
                        }
                        
                        /*
                        while self.imageLoadCount < videoItemList.count {
                            //print ("\(self.imageLoadCount)")
                        }
                         */
                        
                    }
                } else {
                    if let errCode = resultJSON["status"].int {
                        if let errMessage = resultJSON["message"].string {
                            print("Error getting videos. CODE (\(errCode)) : \(errMessage)")
                        }
                    }
                }
                
                //print(resultJSON)
                //completion(videoItemList)

            }
        }
        
        //return deserializeFromMock() //Just use mock for now. Will be using RESTful API
    }
    
    internal func loadImages(videoItemList: [VideoItemModel]) {
        for i in 0 ... (videoItemList.count - 1) {
            //Load thumbnails
            //print ("Thumbnail URL: \(videoItemList[i].thumbnailUrl!)")
            Alamofire.request(videoItemList[i].thumbnailUrl!, method: .get).responseImage() { (response) in
                //print("Thumbnail req finished")
                if(response.error == nil) {
                    self.imageLoadCount += 1
                    
                    if let image = response.result.value {
                        //print("image downloaded: \(image)")
                        
                        videoItemList[i].thumbnail = image

                    }
                    
                    if (self.imageLoadCount == videoItemList.count)
                    {
                        for i in 0 ... (videoItemList.count - 1) {
                            if let imageView = videoItemList[i].thumbnailView {
                                imageView.image = videoItemList[i].thumbnail
                            }
                        }
                        
                        if let container = self.containerView as? UITableView {
                            container.reloadData()
                        } else if let container = self.containerView as? UICollectionView {
                            container.reloadData()
                        }
                    }
                    
                } else {
                    print ("Error downloading thumbnail!")
                }
                
            }
        }
    }
    
    func deserializeFromMock() -> [VideoItemModel] {
        preconditionFailure("This method must be overridden")
    }
}
