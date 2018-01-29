//
//  FavoriteVideoItemDeserializer.swift
//  FifTube
//
//  Created by Poing on 1/24/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class FavoriteVideoItemDeserializer: BaseVideoItemDeserializer {
    override init() {
        super.init()
        command = "https://fema-dev.fifgroup.co.id/fema-video-service/api/m/fiftube/favourite"
    }
    
    override func deserializeFromMock() -> [VideoItemModel] {
        
        var itemList : [VideoItemModel] = []
        
        //Create 10 items for mock
        for _ in 0...9 {
            let videoItem = VideoItemModel()
            videoItem.thumbnail = UIImage(named: "Thumbnail2_mock")
            videoItem.profilePic = UIImage(named: "Profpic2_mock")
            itemList.append(videoItem)
        }
        
        return itemList
    }
}
