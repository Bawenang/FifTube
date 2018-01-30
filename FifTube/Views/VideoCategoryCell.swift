//
//  VideoCategoryCell.swift
//  FifTube
//
//  Created by Poing on 1/20/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import SwiftyJSON

enum VideoListType : Int {
    case AllVideo, RecentViews, TopViews, TopLikes, Favorite, ChannelDetail
}

class VideoCategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, VideoItemCellDelegate {

    

    var delegate: VideoCategoryDelegate?
    
    var listType : VideoListType?
    var useMock : Bool = false
    var videoItemList : [VideoItemModel]?
    var currentPage: Int = 1
    var channelId: String = ""
    var totalCount: Int = 0
    
    let reusableCellId = "videoItemCell"
    let nibVideoItemCell = UINib(nibName: "VideoItemCell", bundle: nil)
    
    
    //Collection view for menu buttons
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        //Create subview (collection) for the menu buttons
        //Register cell's XIB and class
        cv.register(nibVideoItemCell, forCellWithReuseIdentifier: reusableCellId)
        //Set subview BG color
        //cv.backgroundColor = UIColor.white
        cv.backgroundColor = UIColor.bgColor
        cv.contentInsetAdjustmentBehavior = .never
        cv.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        cv.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadList () {
        switch listType! {
        case .AllVideo:
            if (useMock) {
                videoItemList = AllVideoItemDeserializer().deserializeFromMock()
            } else {
                let parameters = [ "currentPage" : currentPage ]
                AllVideoItemDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
            }
        case .RecentViews:
            if (useMock) {
                videoItemList = RecentVideoItemDeserializer().deserializeFromMock()
            } else {
                let parameters = [ "currentPage" : currentPage, "username" : FifTubeManager.sharedInstance.getUsername() ] as [String : Any]
                RecentVideoItemDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
            }
        case .TopViews:
            if (useMock) {
                videoItemList = TopViewsVideoItemDeserializer().deserializeFromMock()
            } else {
                let parameters = [ "currentPage" : currentPage ]
                TopViewsVideoItemDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
            }
        case .TopLikes:
            if (useMock) {
                videoItemList = TopLikesVideoItemDeserializer().deserializeFromMock()
            } else {
                let parameters = [ "currentPage" : currentPage ]
                TopLikesVideoItemDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
            }
        case .Favorite:
            if (useMock) {
                videoItemList = FavoriteVideoItemDeserializer().deserializeFromMock()
            } else {
                let parameters = [ "currentPage" : currentPage, "username" : FifTubeManager.sharedInstance.getUsername() ] as [String : Any]
                FavoriteVideoItemDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
            }
        case .ChannelDetail:
            if (useMock) {
                videoItemList = ChannelDetailVideoItemDeserializer().deserializeFromMock()
            } else {
                let parameterSub : JSON = ["value" : (channelId)]
                let subJSON = JSON(parameterSub)
                let parameters = [ "currentPage" : currentPage, "username" : FifTubeManager.sharedInstance.getUsername(), "data" : parameterSub.rawValue ] as [String : Any]
                ChannelDetailVideoItemDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
            }
        }
    }
    
    func deserializationCompleted(videoItem: [VideoItemModel], totalCount: Int) {
        self.totalCount = totalCount
        
        if let _ = videoItemList{
            self.videoItemList!.append(contentsOf: videoItem)
        } else {
            self.videoItemList = videoItem
        }
        self.collectionView.reloadData()
    }
    
    public func setup(videoListType: VideoListType, isUseMock: Bool) {
        
        self.listType = videoListType
        self.useMock = isUseMock
        
        loadList()
        
        //Add subview
        self.addSubview(collectionView)
        
        //Set subview constraints
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        self.addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        
    }
    
    func tapFaveButton(fromCell sender: VideoItemCell) {
        //let indexPath = collectionView.indexPath(for: sender)
        
        sender.toggleFave()
    }
    
    func didSelectVideoAt(fromCell cell: VideoItemCell) {
        delegate?.didSelectVideo(videoItem: cell.videoItem!)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! VideoItemCell
        
        delegate?.didSelectVideo(videoItem: cell.videoItem!)
    }
    
    // Mark: UICollectionVideDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        if let vids = videoItemList {
            return vids.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let vids = videoItemList {
            return vids.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellId, for: indexPath)
        let myCell = cell as! VideoItemCell
        let i = indexPath.item
        
        if let vids = videoItemList {
            myCell.setup(videoItem: vids[i])
        }
        
        myCell.delegate = self
            
        return myCell
        
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = CGFloat( 16 )
        let descriptionSize = CGFloat( 76 )
        let cellWidth = frame.width - paddingSpace - paddingSpace
        let thumbnailSize = (cellWidth / 16) * 9
        let cellHeight = thumbnailSize + descriptionSize + paddingSpace
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let videoItems = videoItemList {
            if videoItems.count < self.totalCount && indexPath.row + 1 == videoItems.count {
                print("At the end of the list. Reload new data!")
                currentPage += 1
                loadList()
            }
        }
    }
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}
