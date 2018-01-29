//
//  ChannelListItemDeserializer.swift
//  FifTube
//
//  Created by Poing on 1/23/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChannelListItemDeserializer {
    let headerEncoding : String = "application/json"
    
    var command : String = "https://fema-dev.fifgroup.co.id/fema-video-service/api/m/channel/"
    var imageLoadCount : Int = 0
    
    init() {
        
    }
    
    
    func deserialize(params: [String:Any], completion: @escaping ([ChannelListItemModel], Int)->Void) {
        
        let headers = [
            "X-Auth-Token" : FifTubeManager.sharedInstance.getToken(),
            "Content-Type" : headerEncoding
        ]
        
        
        Alamofire.request(command, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                let resultJSON = JSON(responseData.result.value!)
                
                var channelItemList: [ChannelListItemModel] = []
                
                if let isOk = resultJSON["statusCode"].int {
                    if isOk == 0 {
                        //Load json to ChannelListItemModel
                        if let channelList = resultJSON["dataList"].array {
                            if channelList.count > 0 {
                                for i in 0 ... (channelList.count - 1) {
                                    let item = ChannelListItemModel()
                                    item.id = channelList[i]["id"].string!
                                    item.thumbnailUrl = channelList[i]["thumbnailUrl"].string!
                                    item.title = channelList[i]["title"].string!
                                    //item.subscription = channelList[i]["totalViewer"].int!
                                    
                                    channelItemList.append(item)
                                }
                                
                            }
                        }
                        
                        let totalCount = resultJSON["totalCount"].int!
                        completion(channelItemList, totalCount)
                        
                        //Load Images
                        self.loadImages(channelItemList: channelItemList)
                        
                        
                    }
                }
                
                //print(resultJSON)
                
                
            }
        }
        
        //return deserializeFromMock() //Just use mock for now. Will be using RESTful API
    }
    
    internal func loadImages(channelItemList: [ChannelListItemModel]) {
        for i in 0 ... (channelItemList.count - 1) {
            if channelItemList.count > 0 {
                //Load thumbnails
                Alamofire.request(channelItemList[i].thumbnailUrl!).responseData() { (response) in
                    if(response.error == nil) {
                        self.imageLoadCount += 1
                        
                        if let data = response.data {
                            channelItemList[i].thumbnail = UIImage(data: data)
                            if let imageView = channelItemList[i].thumbnailView {
                                imageView.image = channelItemList[i].thumbnail
                            }
                        }
                    }
                }
            }
        }
    }
    
    func deserializeFromMock() -> [VideoItemModel] {
        preconditionFailure("This method must be overridden")
    }

}
