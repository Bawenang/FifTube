//
//  CommentModel.swift
//  FifTube
//
//  Created by Poing on 1/31/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class CommentModel {
    var id : String = ""
    var commentBy: String = "Mr. X"
    var commentDate: Date = Date()
    var text: String = "Lorem Ipsum"
    var title: String = "comment"
    
    func createDateText() -> String {
        
        let descStr = "\(commentDate.mediumDate) | \(commentDate.shortTime)"
        
        return descStr
    }
}
