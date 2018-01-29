//
//  TopTabBarCell.swift
//  FifTube
//
//  Created by Poing on 1/21/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class TopTabBarCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var underBar: UIView!
    
    var isUnderBarHidden: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.textColor = UIColor.gray
        underBar.isHidden = true
    }

    func setupCell(title: String, isUseUnderBar: Bool = true)
    {
        self.titleLabel.text = title
        self.isUnderBarHidden = !isUseUnderBar
        if (self.isUnderBarHidden) {
            underBar.isHidden = true
        }
        
    }
    
    
    override var isSelected: Bool{
        didSet {
            titleLabel.textColor = isSelected ? UIColor.navBarColor : UIColor.gray
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize) : UIFont.systemFont(ofSize: titleLabel.font.pointSize)
            
            if !isUnderBarHidden {
                underBar.isHidden = isSelected ? false : true
            }
            
        }
    }
 
}
