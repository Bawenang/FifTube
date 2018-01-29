//
//  VideoEntryDeserializer.swift
//  FifTube
//
//  Created by Poing on 1/25/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import Foundation


class VideoEntryDeserializer {
    func deserialize() -> [VideoPlayerEntryModel]? {
        return deserializeFromMock() //Just use mock for now. Will be using RESTful API
    }
    
   func deserializeFromMock() -> [VideoPlayerEntryModel]? {
        
        var itemList : [VideoPlayerEntryModel] = []
        
        //Create 10 items for mock
        for _ in 0...9 {
            let video = VideoPlayerEntryModel()
            video.vidUrl = "https://youtu.be/VuuTavE58y4"
            itemList.append(video)
        }
        
        return itemList
    }
    
    static func getMock() -> VideoPlayerEntryModel {
        let videoPlayerEntry = VideoPlayerEntryModel()
        
        
        videoPlayerEntry.vidUrl = "https://youtu.be/VuuTavE58y4"
        videoPlayerEntry.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        var comments : [VideoCommentEntryModel] = []
        
        for _ in 0 ... 10 {
            let comment = VideoCommentEntryModel()
            comment.commenter = "Muad'dib"
            comment.comment = "I must not fear. Fear is the mind-killer. Fear is the little-death that brings total obliteration. I will face my fear. I will permit it to pass over me and through me. And when it has gone past I will turn the inner eye to see its path. Where the fear has gone there will be nothing. Only I will remain."
            comment.dateTime = Date()
            comments.append(comment)
        }
        
        videoPlayerEntry.commentList = comments
        
        return videoPlayerEntry
    }
}
