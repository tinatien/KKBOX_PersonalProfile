//
//  PlaylistCollectionViewCell.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/23.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playlistLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configCell(playlist: Playlist) {
        let imageURLString = playlist.songs![0].album?.imageURL
        let imageURL = NSURL(string: imageURLString!)
        let imageData = NSData(contentsOfURL: imageURL!)
        let image = UIImage(data: imageData!)
        
        self.imageView.image = image
        self.playlistLabel.text = playlist.playlistName
    }
}
