//
//  VideoPlayerTableViewController.swift
//  FifTube
//
//  Created by Poing on 1/25/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import SwiftyJSON

class VideoPlayerTableViewController: UITableViewController, VideoPlayerDelegate {

    

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
        
        /*
        self.navigationController?.navigationBar.topItem?.title = " "
        self.title = " "
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        */
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tableView.register(nibVidPlayer, forCellReuseIdentifier: reuseIdentifiers[0])
        self.tableView.register(nibVidDescription, forCellReuseIdentifier: reuseIdentifiers[1])
        self.tableView.register(nibVidAddComment, forCellReuseIdentifier: reuseIdentifiers[2])
        self.tableView.register(nibVidCommentList, forCellReuseIdentifier: reuseIdentifiers[3])
        
        self.tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        //print("VideoPlayerTableViewController viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(entry: VideoPlayerEntryModel) {
        self.videoEntry = entry
        
        //Generate comments
        let parameterSub : JSON = ["value" : self.videoEntry?.id]
        let subJSON = JSON(parameterSub)
        let parameters = [ "currentPage" : currentPage, "username" : FifTubeManager.sharedInstance.getUsername(), "data" : parameterSub.rawValue, "descending" : false ] as [String : Any]
        CommentDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
    }
    
    func deserializationCompleted(commentItemList: [CommentModel], totalCount: Int) {
        self.totalCount = totalCount
        
        if let _ = commentList{
            self.commentList!.append(contentsOf: commentItemList)
        } else {
            self.commentList = commentItemList
        }
    
        tableView.reloadData()
        
    }
    
    func onBackButton() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let comments = self.commentList {
            return self.commentIdOffset + comments.count
        } else {
            return self.commentIdOffset
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers[indexPath.section], for: indexPath)
        
                print("VideoPlayerTableViewController cellForRowAt")

        setupCell(cell, forSection: indexPath.section)
        
        return cell
    }
    
    func setupCell(_ cell: UITableViewCell, forSection: Int)
    {
        switch forSection {
        case 0: //videoplayer
            let vidPlayerCell = cell as! VideoPlayerTableViewCell
            vidPlayerCell.setup(withEntry: self.videoEntry!)
            vidPlayerCell.delegate = self
        case 1:
            let descCel = cell as! VideoDescriptionTableViewCell
            descCel.setup(withEntry: self.videoEntry!)
        case 2: break
        default:
            let descCel = cell as! CommentCell
            descCel.setup(withEntry: commentList![forSection - commentIdOffset])
            break
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
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("VideoPlayerTableViewController viewDidAppear")
        
        //Do each cell's setups
        
        let indexPath = IndexPath(row: 0, section: 0)
        let setupPlayerCell = self.tableView.cellForRow(at: indexPath) as! VideoEntrySetupBase
        setupPlayerCell.setup(withEntry: self.videoEntry!)
 
    }
 */
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
