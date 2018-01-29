//
//  VideoPlayerTableViewCell.swift
//  FifTube
//
//  Created by Poing on 1/24/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerView: UIView {
    
    var vidUrl : String = "https://youtu.be/VuuTavE58y4"
    
    
    func createAndPlayPlayer()
    {
        //Create AVPlayer view
        let videoURL = URL(string: vidUrl)
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.frame
        self.layer.addSublayer(playerLayer)
        player.play()
    }

}

class VideoPlayerTableViewCell: UITableViewCell, VideoEntrySetupBase {

    @IBOutlet weak var videoView: VideoPlayerView!
    
    var delegate : VideoPlayerDelegate?
    
    var videoPlayerEntry: VideoPlayerEntryModel?
    
    /*
    let view: VideoPlayerView = {
        let player = VideoPlayerView()
        return player
    }()
 */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("VideoPlayerTableViewCell awakeFromNib")
        //setup()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(withEntry: VideoPlayerEntryModel) {
        videoPlayerEntry = withEntry
        videoView.vidUrl = (videoPlayerEntry?.vidUrl)!
        videoView.createAndPlayPlayer()
        
        
        //Create backbutton
        let btn: UIButton = UIButton(frame: CGRect(x: 5, y: 5, width: 18, height: 30))
        btn.backgroundColor = UIColor.clear
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(named: "Back_button"), for: .normal)
        btn.alpha = 0.8
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        btn.tag = 1
        self.videoView.addSubview(btn)
        
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            delegate?.onBackButton()
        }
    }

}
