//
//  FavoriteCollectionViewController.swift
//  FifTube
//
//  Created by Poing on 1/24/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class FavoriteCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, VideoCategoryDelegate{
    
    private let reuseIdentifier = "videoCategoryCell"
    var videoPlayerEntry: VideoPlayerEntryModel?
    var videoItem: VideoItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(VideoCategoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.contentInsetAdjustmentBehavior = .never
        self.collectionView?.contentInset = UIEdgeInsetsMake(65, 0, 0, 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(65, 0, 0, 0)
        
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        //SetNavBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapSearchButton))
    }
    
    func scrollToItem(_ item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
    }
    
    @IBAction func tapSearchButton(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCategoryCell
        
        // Configure the cell
        cell.setup(videoListType: VideoListType.Favorite, isUseMock: false )
        cell.delegate = self
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        //let paddingSpace = CGFloat( 10 )
        let cellWidth = view.frame.width
        let cellHeight = view.frame.height - collectionView.contentInset.top - collectionView.contentInset.bottom
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func didSelectVideo(videoItem: VideoItemModel) {
        //videoPlayerEntry = VideoEntryDeserializer.getMock()
        VideoEntryDeserializer().deserialize(videoId: videoItem.id, completion: deserializationCompleted)
        self.videoItem = videoItem
        
        
    }
    
    func deserializationCompleted(videoEntry: VideoPlayerEntryModel) {
        
        self.videoPlayerEntry = videoEntry
        self.videoPlayerEntry?.thumbnail = self.videoItem?.thumbnail
        
        performSegue(withIdentifier: "videoDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "videoDetailSegue" {
            
            let dest = segue.destination as! VideoPlayerTableViewController
            dest.setup(entry: self.videoPlayerEntry!)
        }
    }
    
}

