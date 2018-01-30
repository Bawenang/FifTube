//
//  VideoPlayerTableViewCell.swift
//  FifTube
//
//  Created by Poing on 1/24/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit
import WistiaKit
import WistiaKitCore
import CoreMedia


class VideoPlayerTableViewCell: UITableViewCell, VideoEntrySetupBase, WistiaPlayerDelegate {

    var wistiaPlayer : WistiaPlayer?

    @IBOutlet weak var wistiaPlayerView: WistiaFlatPlayerView!
    @IBOutlet weak var thumbnailView: UIImageView!
    
    var delegate : VideoPlayerDelegate?
    
    var videoPlayerEntry: VideoPlayerEntryModel?
    
    var hashedString : String?
    var referrer: String?
    
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
    
    override func prepareForReuse() {
        thumbnailView.isHidden = false
    }
    
    func setup(withEntry: VideoPlayerEntryModel) {
        self.videoPlayerEntry = withEntry
        splitUrl(withEntry.url!)
        self.wistiaPlayer = WistiaPlayer(referrer: self.referrer!)
        self.wistiaPlayerView.wistiaPlayer = self.wistiaPlayer!
        self.wistiaPlayerView.wistiaPlayer?.replaceCurrentVideoWithVideo(forHashedID: hashedString!)
        self.wistiaPlayerView.wistiaPlayer?.play()
        self.thumbnailView.isHidden = true
        if let thumb = withEntry.thumbnail {
            thumbnailView.image = thumb
        }
        
        
        //Create backbutton
        let btn: UIButton = UIButton(frame: CGRect(x: 5, y: 5, width: 18, height: 30))
        btn.backgroundColor = UIColor.clear
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(named: "Back_button"), for: .normal)
        btn.alpha = 0.8
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        btn.tag = 1
        self.wistiaPlayerView.addSubview(btn)
        
    }
    
    func splitUrl(_ urlStr: String) {
        //let urlArray = urlStr.components(separatedBy: "/")
        //self.hashedString = urlArray.last
        let url : URL = URL(string: urlStr)!
        self.hashedString = url.lastPathComponent
        self.referrer = url.deletingLastPathComponent().absoluteString
        
        print("referrer: \(self.referrer!) | hashed: \(self.hashedString!)")
    }
    
    // MARK: WistiaPlayerDelegate
    func wistiaPlayer(_ player: WistiaPlayer, didChangeStateTo newState: WistiaPlayer.State) {
        switch newState {
        case .videoReadyForPlayback:
            thumbnailView.isHidden = true
            wistiaPlayer?.play()
        default: break
            //ignoring, but probably shouldn't
        }
    }
    
    func wistiaPlayer(_ player: WistiaPlayer, didChangePlaybackRateTo newRate: Float) {
        
    }
    
    func wistiaPlayer(_ player: WistiaPlayer, didChangePlaybackProgressTo progress: Float, atCurrentTime currentTime: CMTime, ofDuration duration: CMTime) {
    
    }
    
    func didPlayToEndTime(of player: WistiaPlayer) {
        
    }
    
    func wistiaPlayer(_ player: WistiaPlayer, willLoadVideoForMedia media: WistiaMedia, usingAsset asset: WistiaAsset?, usingHLSMasterIndexManifest: Bool) {
    
    }
    

    
    
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            delegate?.onBackButton()
        }
    }

}
