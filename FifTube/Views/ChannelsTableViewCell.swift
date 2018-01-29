//
//  ChannelsTableViewCell.swift
//  FifTube
//
//  Created by Poing on 1/23/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class ChannelsTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subscriptionLabel: UILabel!
    
    var channelItem: ChannelListItemModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
        
            channelItem?.thumbnailView = nil
            channelItem = nil
    }
    
    func setup(channelItem: ChannelListItemModel)
    {
        self.channelItem = channelItem
        
        thumbnailImageView.image = channelItem.thumbnail
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 30
        thumbnailImageView.layer.masksToBounds = true
        
        titleLabel.text = channelItem.title
        
        subscriptionLabel.text = channelItem.getSubscribers()
        
        channelItem.thumbnailView = thumbnailImageView
    }
}
