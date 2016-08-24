//
//  FollowingArtistCollectionViewCell.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/23.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class FollowingArtistCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    
    
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

    override func drawRect(rect: CGRect) {
        imageView.layer.cornerRadius = imageView.bounds.size.width/2
        imageView.clipsToBounds = true
    }
    
    func configCell(artist: Artist) {
        let imageURLString = artist.imageURL
        let imageURL = NSURL(string: imageURLString)
        let imageData = NSData(contentsOfURL: imageURL!)
        let image = UIImage(data: imageData!)
        
        self.imageView.image = image
        self.artistLabel.text = artist.artistName
    }
}
