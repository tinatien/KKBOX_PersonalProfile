//
//  Story.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/22.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import Foundation

class Story: NSObject {
    
    internal var _storyId: String!
    internal var _storyName: String!
    internal var _storyContent: String!
    internal var _storyLikeNum: Int!
    internal var _storySong: Song!
    internal var _storySongName: String!
    internal var _storySongCoverUrl: String!
    internal var _stroySongArtistName: String!
    internal var _storySongAlbumName: String!
    internal var _whoPostStory: String!
    internal var _whoPostStoryImgUrl: String!
    internal var _storyPostTime: String!
    internal var _storyComments = [Comment]()
    internal var _reasonToRecommend: String!
    
  
    
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
    var storyName: String {
        get{
            if _storyName == nil {
                _storyName = ""
            }
            return _storyName
        }
        
    }
    var storyContent: String {
        get{
            if _storyContent == nil {
                _storyContent = ""
            }
            return _storyContent
            
        }
    }
    
    var storyLikeNum: Int {
        get{
            if _storyLikeNum == nil {
                _storyLikeNum = 0
            }
            return _storyLikeNum
        }
        
    }
    var storySong: Song {
        
            return _storySong
    }
        
    

    var storySongName: String {
        get{
            if _storySongName == nil {
                _storySongName = ""
            }
            return _storySongName
    
        }
    }

    var stroySongArtistName: String {
        get{
            if _stroySongArtistName == nil {
                _stroySongArtistName = ""
            }
            return _stroySongArtistName
        }

    }
    
    var storySongAlbumName: String {
        get{
            if _storySongAlbumName == nil {
                _storySongAlbumName = ""
            }
            return _storySongAlbumName
            
        }
    }
    
    var whoPostStory: String {
        get{
            if _whoPostStory == nil {
                _whoPostStory = ""
            }
            return _whoPostStory
        }
        
    }
    
    var storyPostTime: String {
        get{
            if _storyPostTime == nil {
                _storyPostTime = ""
            }
            return _storyPostTime
        }
        
    }
    
    var whoPostStoryImgUrl: String {
        get{
            if _whoPostStoryImgUrl == nil {
                _whoPostStoryImgUrl = ""
            }
            return _whoPostStoryImgUrl
        }
        
    }
    
    var storySongCoverUrl: String {
        get{
            if _storySongCoverUrl == nil {
                _storySongCoverUrl = ""
            }
            return _storySongCoverUrl
        }
        
    }

    
    var storyComments: [Comment] {
        
            return _storyComments
        
    }

    
    var reasonToRecommend: String{
        get{
            if _reasonToRecommend == nil {
                _reasonToRecommend = ""
            }
            return _reasonToRecommend
        }

    }
    
    
    init(story: Dictionary<String, AnyObject>) {
        super.init()
        
        if let reason = story["reason"] as? Dictionary<String, AnyObject>{
            if let name = reason["name"] as? String{
                self._whoPostStory = name
            }
            if let imgUrl = reason["image"] as? String{
                self._whoPostStoryImgUrl = imgUrl
            }
            
        }
        
        
        
        
        
            if let storyId = story["story_id"] as? String{
                self._storyId = storyId
            }
        
        
            if let storyName = story["title"] as? String{
                self._storyName = storyName
            }
        
        
            if let storyContent = story["content"] as? String{
                self._storyContent = storyContent
            }
        
        
            if let storyLikeNum = story["collect_num"] as? Int{
                self._storyLikeNum = storyLikeNum
            }
        
            
            if let storySongId = story["track"] as? Dictionary<String, AnyObject>{
                if let name = storySongId["name"] as? String{
                    self._storySongName = name
                }
                if let album = storySongId["album"] as? Dictionary<String, AnyObject>{
                    if let name = album["name"] as? String {
                        self._storySongAlbumName = name
                    }
                    
                    if let img = album["images"] as? [Dictionary<String, AnyObject>]{
                        if let url = img[0]["url"] as? String{
                            self._storySongCoverUrl = url
                        }
                    }
                    
                    if let artist = album["artist"] as? Dictionary<String, AnyObject>{
                        if let name = artist["name"] as? String{
                            self._stroySongArtistName = name
                        }
                    }
                }
                
            }
        
        
            if let whoPostStory = story["user_name"] as? String{
                self._whoPostStory = whoPostStory
            }
        
        
            if let storyPostTime = story["time"] as? String{
                self._storyPostTime = storyPostTime
            }
        
        
            if let storyComment = story["comments"] as? [Dictionary<String, AnyObject>]{
                for obj in storyComment{
                    if let commentObj = obj as? Dictionary<String, AnyObject>{
                         var comment = Comment(comment: commentObj)
                        
                        self._storyComments.append(comment)
                    }
                }
            }
        
        
            if let whoPostStoryImgUrl = story["user_image"] as? String{
                self._whoPostStoryImgUrl = whoPostStoryImgUrl
            }
    
        if let whoPostStoryImgUrl = story["image"] as? String{
            self._whoPostStoryImgUrl = whoPostStoryImgUrl
        }
        
        
            
    }
        

        
        
}

