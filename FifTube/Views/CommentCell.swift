//
//  CommentCell.swift
//  FifTube
//
//  Created by Poing on 1/31/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLAbel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
        parentView.layer.cornerRadius = 6
        parentView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(withEntry: CommentModel)
    {
        dateLabel.text = withEntry.createDateText()
        nameLabel.text = withEntry.commentBy
        textLAbel.text = withEntry.text

    }
}
