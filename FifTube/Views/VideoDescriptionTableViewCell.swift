//
//  VideoDescriptionTableViewCell.swift
//  FifTube
//
//  Created by Poing on 1/24/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class VideoDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var description_1: UILabel!
    @IBOutlet weak var description_2: UILabel!
    @IBOutlet weak var description_3: UILabel!
    
    @IBOutlet weak var faveButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    var faveLikeDelegate: FaveLikeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(withEntry: VideoPlayerEntryModel)
    {
        title.text = withEntry.title
        description_1.text = withEntry.createDescription1()
        description_2.text = withEntry.createDescription2()
        
        description_3.text = withEntry.description
        
        faveButton.isSelected = withEntry.favorite
        likeButton.isSelected = withEntry.liked
    }
    
    @IBAction func tapFaveButton(_ sender: Any) {
        self.faveLikeDelegate?.onTapFave(isFave: faveButton.isSelected)
    }
    @IBAction func tapLikeButton(_ sender: Any) {
        self.faveLikeDelegate?.onTapLike(isLike: likeButton.isSelected)
    }
}
