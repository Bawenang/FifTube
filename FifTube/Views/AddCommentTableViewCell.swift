//
//  AddCommentTableViewCell.swift
//  FifTube
//
//  Created by Poing on 1/24/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class AddCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentTextField: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentTextField.text = ""
        commentTextField.layer.cornerRadius = 6
        commentTextField.layer.masksToBounds = true
        
        submitButton.layer.cornerRadius = 4
        submitButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
