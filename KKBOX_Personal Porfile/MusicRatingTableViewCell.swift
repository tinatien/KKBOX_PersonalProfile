//
//  MusicRatingTableViewCell.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/25.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class MusicRatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(song: Song) {
        let imageURL = NSURL(string: (song.album?.imageURL)!)
        let imageData = NSData(contentsOfURL: imageURL!)
        let image = UIImage(data: imageData!)
        
        self.albumImageView.image = image
        self.songLabel.text = song.songName
        self.artistLabel.text = song.album?.artist?.artistName
    }
    
}
