//
//  VideoItemModel.swift
//  FifTube
//
//  Created by Poing on 1/21/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class VideoItemModel{
    var id : String = ""
    var thumbnail: UIImage?
    var thumbnailUrl : String?
    var profilePic: UIImage?
    var profilePicUrl: String?
    var title: String = "Video Title Placeholder"
    var createdBy: String = "Uploader Name Placeholder"
    var totalViews: Int = 0
    var createdDate: Date = Date()
    var isFavorite: Bool = false
    var thumbnailView : UIImageView?
    var profilePicView : UIImageView?
    
    func createDescriptionString() -> String {
        let viewStr = getSimpleIntString(fromInt: totalViews)
        let desc = createdBy + " • " + "\(viewStr) views • \(createdDate.mediumDate)"
        return desc
    }
    
    func getSimpleIntString(fromInt: Int) -> String {
        var strRes = ""
        if fromInt > 1000000 {
            let res: Float = Float(fromInt) / 1000000
            strRes = "\(Int(res))m"
        } else if fromInt > 1000 {
            let res: Float = Float(fromInt) / 1000
            strRes = "\(Int(res))k"
        } else {
            strRes = "\(fromInt)"
        }
        
        return strRes
    }
}
