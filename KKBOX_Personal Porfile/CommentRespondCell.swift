//
//  CommentRespondVellTableViewCell.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/16.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class CommentRespondCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var whoPostImg: MaterialProfileImgView!
    
    @IBOutlet weak var whoPostNameLabe: MaterialLabel!
    
    @IBOutlet weak var whoPostTime: UILabel!
    
    @IBOutlet weak var postContent: UITextView!

    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    
    func configureCell(comment: Comment) {
        self.whoPostNameLabe.text = comment.whoPostComment
        self.whoPostTime.text = comment.postCommentTime
        self.postContent.text = comment.commentContent
        
        let profileImageURL = NSURL(string: comment.commentPostManPhototUrl)
        let profileImageData = NSData(contentsOfURL: profileImageURL!)
        
        if let imgData = profileImageData{
            let profileImg = UIImage(data: imgData)
            self.whoPostImg.image = profileImg
        }
        
    }
    
    
    
    
}
