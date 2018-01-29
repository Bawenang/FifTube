//
//  ChannelListItemModel.swift
//  FifTube
//
//  Created by Poing on 1/23/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class ChannelListItemModel{
    var id: String?
    var thumbnail: UIImage?
    var thumbnailUrl: String?
    var title: String = "Channel Stump"
    var subscription: Int = 0
    var thumbnailView : UIImageView?
    
    func getSubscribers() -> String {
        let ret = "\(getSimpleIntString(fromInt: subscription)) subscribers"
        return ret
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
