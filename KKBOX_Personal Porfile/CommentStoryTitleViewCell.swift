//
//  CommentStoryTitleView.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/16.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class CommentStoryTitleViewCell: UITableViewCell {

    @IBOutlet weak var postCommentTextField: MaterialTextField!
    @IBOutlet weak var storyTitle: UILabel!

    @IBOutlet weak var storyPostTime: UILabel!
    
    @IBOutlet weak var storyContentTextView: MaterialTextView!
    
    @IBOutlet weak var userProfileImg: MaterialProfileImgView!
    
    var txt = ""
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.postCommentTextField.delegate = self
        
    }
    
    func configureCell(story: Story) {
        self.storyTitle.text = story.storyName
        self.storyPostTime.text = story.storyPostTime
        self.storyContentTextView.text = story.storyContent
    }
    
}


extension CommentStoryTitleViewCell: UITextFieldDelegate{
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "想些什麼...ggggggg"
            textView.textColor = UIColor.lightGrayColor()
        }
        self.txt = textView.text
        
    }
    
}
