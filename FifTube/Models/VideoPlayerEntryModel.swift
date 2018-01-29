//
//  VideoPlayerEntryModel.swift
//  FifTube
//
//  Created by Poing on 1/25/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class VideoCommentEntryModel {
    var dateTime : Date = Date.init()
    var commenter : String = "Mr. Y"
    var comment : String?
}

class VideoPlayerEntryModel{
    var vidUrl: String?
    var title: String = "Video Placeholder"
    var createdDate: Date = Date()
    var uploader: String = "Mr. X"
    var views: Int = 0
    var likes: Int = 0
    var description: String?
    var isFavorite: Bool = false
    var isLike: Bool = false
    var commentList: [VideoCommentEntryModel]?
    
    func createDescription1() -> String {
        
        let descStr = "\(createdDate.mediumDate) | \(createdDate.shortTime) | by \(self.uploader)"
        
        return descStr
    }
    
    func createDescription2() -> String {
        
        var commentCount : Int = 0
        if let comments = self.commentList {
            commentCount = comments.count
        }
        
        let descStr = "\(getSimpleIntString(fromInt: self.views)) views • \(getSimpleIntString(fromInt: self.likes)) views • \(getSimpleIntString(fromInt: commentCount)) comments"
        
        return descStr
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
