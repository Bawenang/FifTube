//
//  VideoItemDelegate.swift
//  FifTube
//
//  Created by Poing on 1/23/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

protocol VideoItemCellDelegate {
    func tapFaveButton(fromCell: VideoItemCell, withInitialState: Bool)
    func didSelectVideoAt(fromCell: VideoItemCell)
}
