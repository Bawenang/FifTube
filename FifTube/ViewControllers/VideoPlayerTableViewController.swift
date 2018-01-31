//
//  VideoPlayerTableViewController.swift
//  FifTube
//
//  Created by Poing on 1/25/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import SwiftyJSON

class VideoPlayerTableViewController: UITableViewController, VideoPlayerDelegate, AddCommentDelegate, FaveLikeDelegate {

    private let reuseIdentifiers : [String] = [ "videoPlayerCell", "videoDescriptionCell", "videoAddCommentCell", "commentCell"]
    
    let nibVidPlayer = UINib(nibName: "VideoPlayerTableViewCell", bundle: nil)
    let nibVidDescription = UINib(nibName: "VideoDescriptionTableViewCell", bundle: nil)
    let nibVidAddComment = UINib(nibName: "AddCommentTableViewCell", bundle: nil)
    let nibVidCommentList = UINib(nibName: "CommentCell", bundle: nil)
    
    let commentIdOffset : Int = 3
    
    var videoEntry: VideoPlayerEntryModel?
    var commentList: [CommentModel]?
    var totalCount: Int = 0
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tableView.register(nibVidPlayer, forCellReuseIdentifier: reuseIdentifiers[0])
        self.tableView.register(nibVidDescription, forCellReuseIdentifier: reuseIdentifiers[1])
        self.tableView.register(nibVidAddComment, forCellReuseIdentifier: reuseIdentifiers[2])
        self.tableView.register(nibVidCommentList, forCellReuseIdentifier: reuseIdentifiers[3])
        
        self.tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.tableView.backgroundColor = UIColor.bgColor
        
        //print("VideoPlayerTableViewController viewDidLoad")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let player = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VideoPlayerTableViewCell
        player.close()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(entry: VideoPlayerEntryModel) {
        self.videoEntry = entry
        
        //Generate comments
        let parameterSub : JSON = ["id" : self.videoEntry?.id!]
        let parameterSub2 : JSON = ["commentDate"]
        let parameters = [ "currentPage" : currentPage, "username" : FifTubeManager.sharedInstance.getUsername(), "data" : parameterSub.rawValue, "descending" : false, "orderBy" : parameterSub2.rawValue ] as [String : Any]
        CommentDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
    }
    
    func sorterForDate(this:CommentModel, that:CommentModel) -> Bool {
        return this.commentDate > that.commentDate
    }
    
    func deserializationCompleted(commentItemList: [CommentModel], totalCount: Int) {
        self.totalCount = totalCount
        
        if let _ = commentList{
            self.commentList!.append(contentsOf: commentItemList)
        } else {
            self.commentList = commentItemList
        }
        
        self.commentList!.sort(by: sorterForDate)
        
        videoEntry?.commentList = self.commentList
        
        var paths : [IndexPath] = []
        if self.commentList!.count > 0 {
            for i in 0 ... ((self.commentList?.count)! - 1) {
                let path = IndexPath(row: i, section: 3)
                paths.append(path)
            }
        }
        
        tableView.insertRows(at: paths, with: .right)
        
        tableView.reloadSections([1,2], with: .none)
    }
    
    func onBackButton() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rowCount = 1
        
        if (section == 3) {
            if let comments = self.commentList {
                rowCount = comments.count
            } else {
                rowCount = 0
            }
        }
        
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers[indexPath.section], for: indexPath)
        
                print("VideoPlayerTableViewController cellForRowAt")

        setupCell(cell, forIndexPath: indexPath)
        
        return cell
    }
    
    func setupCell(_ cell: UITableViewCell, forIndexPath: IndexPath)
    {
        switch forIndexPath.section {
        case 0: //videoplayer
            let vidPlayerCell = cell as! VideoPlayerTableViewCell
            vidPlayerCell.setup(withEntry: self.videoEntry!)
            vidPlayerCell.delegate = self
        case 1:
            let descCel = cell as! VideoDescriptionTableViewCell
            descCel.setup(withEntry: self.videoEntry!)
            descCel.faveLikeDelegate = self
        case 2: 
            let descCel = cell as! AddCommentTableViewCell
            descCel.delegate = self
        case 3:
            let descCel = cell as! CommentCell
            descCel.setup(withEntry: commentList![forIndexPath.row])
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return view.frame.width * 9 / 16
        case 1:
            return UITableViewAutomaticDimension
        case 2:
            return 164
        case 3:
            return UITableViewAutomaticDimension
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: AddCommentDelegate
    func onTapCommentButton(text: String) {
        let nestedParams : JSON = ["id" : videoEntry?.id!]
        let commentParams = [
            "commentBy" : FifTubeManager.sharedInstance.getUsername(),
            "commentDate" : (Date().timeIntervalSince1970 * 1000).rounded(),
            "text" : text,
            "fiftubeSetup" : nestedParams.rawValue
            ] as [String : Any]
        
        AddCommentHandler().add(params: commentParams, completion: addCommentCompletion)
    }
    
    func addCommentCompletion(comment: CommentModel) {
        self.totalCount += 1
        
        if let _ = commentList{
            self.commentList!.insert(comment, at: 0)
        } else {
            self.commentList = []
            self.commentList!.append(comment)
        }
        
        videoEntry?.commentList?.append(comment)
        
        
        
        tableView.insertRows(at: [IndexPath(row: 0, section: 3)], with: .right)
        
        tableView.reloadSections([1,2], with: .none)
    }
    
    // MARK: FaveLikeDelegate
    func onTapFave(isFave: Bool) {
        if isFave {
            FavoriteLikeHandler().doUnfavorite(videoId: (self.videoEntry?.id)!, completion: completionFave)
        } else {
            FavoriteLikeHandler().doFavorite(videoId: (self.videoEntry?.id)!, completion: completionFave)
        }
    }
    
    func onTapLike(isLike: Bool) {
        FavoriteLikeHandler().doLike(videoId: (self.videoEntry?.id)!, completion: completionLike)
    }
    
    func completionFave(newState: Bool) {
        self.videoEntry?.favorite = newState
        let descCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! VideoDescriptionTableViewCell
        descCell.setup(withEntry: self.videoEntry!)
    }
    
    func completionLike(newState: Bool) {
        self.videoEntry?.liked = newState
        let descCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! VideoDescriptionTableViewCell
        descCell.setup(withEntry: self.videoEntry!)
    }
}
