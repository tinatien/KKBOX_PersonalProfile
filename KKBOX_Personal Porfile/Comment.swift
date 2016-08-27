//
//  Comment.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tie Lin on 2016/8/27.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import Foundation

class Comment: NSObject {
    
    private var _commentId: String!
    private var _commentContent: String!
    private var _postCommentTime: String!
    private var _commentLikeNum: String!
    private var _whoPostComment: String!
    private var _commentPostManPhototUrl: String!
    private var _storyId: String!
    
    var storyId: String {
        set{
            _storyId = newValue
        }
        get{
            if _storyId == nil {
                _storyId = ""
            }
            return _storyId
        }
        
    }
    var commentId: String {
        set{
            _commentId = newValue
        }
        get{
            if _commentId == nil {
                _commentId = ""
            }
            return _commentId
        }
        
    }
    var commentContent: String {
        set{
            _commentContent = newValue
        }
        get{
            if _commentContent == nil {
                _commentContent = ""
            }
            return _commentContent
        }
        
    }
    var postCommentTime: String {
        get{
            if _postCommentTime == nil {
                _postCommentTime = ""
            }
            return _postCommentTime
            
        }
    }
    var whoPostComment: String {
        get{
            if _whoPostComment == nil {
                _whoPostComment = ""
            }
            return _whoPostComment
            
        }
    }
    var commentPostManPhototUrl: String {
        get{
            if _commentPostManPhototUrl == nil {
                _commentPostManPhototUrl = ""
            }
            return _commentPostManPhototUrl
            
        }
    }
    
    init(comment: Dictionary<String, AnyObject>) {
        super.init()
        if let commentId = comment["comment_id"] as? String{
            self._commentId = commentId
        }
        
        
        if let whoPostComment = comment["user_name"] as? String{
            self._whoPostComment = whoPostComment
        }
        
        if let commentPostManPhototUrl = comment["user_image"] as? String{
            self._commentPostManPhototUrl = commentPostManPhototUrl
        }
        
        
        if let commentContent = comment["content"] as? String{
            self._commentContent = commentContent
        }
        
        if let postCommentTime = comment["time"] as? String{
            self._postCommentTime = postCommentTime
            print(self._postCommentTime)
            print("")
        }
        
        if let commentLikeNum = comment["likes_num"] as? String{
            self._commentLikeNum = commentLikeNum
        }
    }
    
    init(story: Story) {
        self._storyId = story.storyId
    }
}