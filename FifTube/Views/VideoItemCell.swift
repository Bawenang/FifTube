//
//  VideoItemCell.swift
//  FifTube
//
//  Created by Poing on 1/21/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class VideoItemCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImgView: UIImageView!
    
    @IBOutlet weak var profPicImgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var faveButton: UIButton!
    
    var videoItem: VideoItemModel?
    
    var delegate: VideoItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        videoItem?.thumbnailView = nil
        videoItem?.profilePic = nil
        
        videoItem = nil
    }

    func setup(videoItem: VideoItemModel)
    {
        self.videoItem = videoItem
        videoItem.thumbnailView = thumbnailImgView
        videoItem.profilePicView = profPicImgView
        
        if let thumbnailImg = videoItem.thumbnail
        {
            thumbnailImgView.image = thumbnailImg
        }
        thumbnailImgView.contentMode = .scaleAspectFill
        thumbnailImgView.clipsToBounds = true
    
        if let profpicImg = videoItem.profilePic
        {
            profPicImgView.image = profpicImg
        }
        profPicImgView.contentMode = .scaleAspectFill
        profPicImgView.layer.cornerRadius = 30
        profPicImgView.layer.masksToBounds = true
        
        titleLabel.text = videoItem.title
        
        descriptionLabel.text = videoItem.createDescriptionString()
        
        faveButton.isSelected = videoItem.isFavorite

    }
    
    @IBAction func tapFaveButton(_ sender: Any) {
        self.delegate?.tapFaveButton(fromCell: self)
    }
    
    func setup(thumbnailImageName: String, profileImageName: String, title: String, description: String, isFavorite: Bool)
    {
        thumbnailImgView.image = UIImage(named: thumbnailImageName)
        thumbnailImgView.contentMode = .scaleAspectFit
        thumbnailImgView.clipsToBounds = true
        
        profPicImgView.image = UIImage(named: profileImageName)
        profPicImgView.contentMode = .scaleAspectFit
        profPicImgView.layer.cornerRadius = 30
        profPicImgView.layer.masksToBounds = true
        
        titleLabel.text = title
        
        descriptionLabel.text = description
        
        faveButton.isSelected = isFavorite
        
        
        
        //addConstraintsWithFormat("H:|-16-[v0]-16-|", views: self)
        //addConstraintsWithFormat("V:|-16-[v0]-16-|", views: self)
    }
    
    func toggleFave() {
        videoItem?.isFavorite = !faveButton.isSelected
        faveButton.isSelected = !faveButton.isSelected
    }
    
    
}
