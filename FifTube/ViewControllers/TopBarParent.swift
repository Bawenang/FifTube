//
//  TopBarScroller.swift
//  FifTube
//
//  Created by Poing on 1/22/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

protocol TopBarParent{
    var categories: [String] { get set}
    func scrollToItem(_ item: Int)
}
