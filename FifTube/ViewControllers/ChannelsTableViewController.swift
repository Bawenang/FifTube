//
//  ChannelsTableViewController.swift
//  FifTube
//
//  Created by Poing on 1/23/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

class ChannelsTableViewController: UITableViewController {
    
    let reusableCellId = "channelsCell"
    let nibChannel = UINib(nibName: "ChannelsTableViewCell", bundle: nil)
    var useMock : Bool = false
    
    var selectedIdx: Int?
    
    var currentPage : Int = 1
    var totalCount : Int = 0
    var channelListItems : [ChannelListItemModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadList()
        
        tableView.register(nibChannel, forCellReuseIdentifier: reusableCellId)
        tableView.backgroundColor = UIColor.bgColor
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        //SetNavBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapSearchButton))
    }
    
    func loadList() {
        let parameters = [ "currentPage" : currentPage ]
        ChannelListItemDeserializer().deserialize(params: parameters, completion: deserializationCompleted)
    }
    
    func deserializationCompleted(channelItems: [ChannelListItemModel], totalCount: Int) {
        self.totalCount = totalCount
        
        if let _ = channelListItems{
            self.channelListItems!.append(contentsOf: channelItems)
        } else {
            self.channelListItems = channelItems
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSearchButton(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIdx = indexPath.section
        performSegue(withIdentifier: "channelDetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "channelDetailsSegue" {
            let selectedCell = tableView.cellForRow(at: IndexPath(row: 0, section: selectedIdx!)) as! ChannelsTableViewCell
            let dest = segue.destination as! ChannelDetailCollectionViewController
            dest.setup(channelName: selectedCell.titleLabel.text!)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let channelItems = self.channelListItems {
            return channelItems.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(16)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let newView = UIView()
        newView.backgroundColor = UIColor.clear
        return newView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId, for: indexPath) as! ChannelsTableViewCell

        // Configure the cell...
        let i = indexPath.section
        
        if let channels = self.channelListItems {
            cell.setup(channelItem: channels[i])
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let channelItems = channelListItems {
            if channelItems.count < self.totalCount && indexPath.section + 1 == channelItems.count {
                print("At the end of the list. Reload new data!")
                currentPage += 1
                loadList()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat( 76 )
    }
    

}
