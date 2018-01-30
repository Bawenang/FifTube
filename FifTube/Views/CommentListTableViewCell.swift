//
//  CommentListTableViewCell.swift
//  FifTube
//
//  Created by Poing on 1/25/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class CommentListTableViewCell: UITableViewCell {

    let reusableCellId = "commentCell"
    let nibVideoItemCell = UINib(nibName: "CommentCell", bundle: nil)
    
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
