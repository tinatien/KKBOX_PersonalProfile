//
//  CollectedAlbumCollectionViewCell.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/23.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class CollectedAlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
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
    
    func configCell(album: Album) {
        let imageURL = NSURL(string: album.imageURL)
        let imageData = NSData(contentsOfURL: imageURL!)
        let image = UIImage(data: imageData!)

        self.imageView.image = image
        self.albumLabel.text = album.albumName
        self.artistLabel.text = album.artist?.artistName
    }

}
