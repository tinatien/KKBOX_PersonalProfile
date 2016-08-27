//
//  DynamicPostWallCell.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tie Lin on 2016/8/27.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class DynamicPostWallCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var trackImg: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var ArtistNameAlbumNameLabel: UILabel!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var commentImg: UIImageView!
    @IBOutlet weak var commentNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func drawRect(rect: CGRect) {
        trackImg.contentMode = .ScaleAspectFill
        trackImg.layer.cornerRadius = 3.0
        trackImg.clipsToBounds = true
    }
    
    func configureCell(story: Story){
        let profileImageURL = NSURL(string: story.whoPostStoryImgUrl)
        let profileImageData = NSData(contentsOfURL: profileImageURL!)
        
        if let imgData = profileImageData{
            let profileImg = UIImage(data: imgData)
            self.profileImg.image = profileImg
        }
        
        let albumCoverImageUrl = NSURL(string: story.storySongCoverUrl)
        let albumCoverImageData = NSData(contentsOfURL: albumCoverImageUrl!)
        if let imgData = albumCoverImageData{
            let albumCoverImg = UIImage(data: imgData)
            self.trackImg.image = albumCoverImg
        }
        
        self.commentNumLabel.text = "\(story.storyComments.count)"
        self.likeNumLabel.text = "\(story.storyLikeNum)"
        self.profileNameLabel.text = story.whoPostStory
        self.storyTitleLabel.text = story.storyName
        self.postDateLabel.text = story.storyPostTime
        self.storyTextView.text = story.storyContent
        self.trackNameLabel.text = story.storySongName
        self.ArtistNameAlbumNameLabel.text = "\(story.stroySongArtistName)"+"  \(story.storySongAlbumName)"
        print(self.ArtistNameAlbumNameLabel.text)
        print(self.trackNameLabel.text)
    }
}
