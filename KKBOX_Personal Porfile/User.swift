//
//  User.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import Foundation

class User: NSObject {
    
    private var _userId: String!
    private var _userName: String!
    private var _userProfileImageUrl: String!
    private var _description: String!
    private var _tags: String!
    private var _followers: [[String:String]]!
    private var _followings: [[String:String]]!
    private var _userPostedStrory = [Story]()
    private var _userLikedStory = [Story]()
    private var _userPostedComment: [Comment]!
    
    var userId: String {
        if _userId == nil {
            _userId = ""
        }
        return _userId
    }
    var userName: String {
        if _userName == nil {
            _userName = ""
        }
        return _userName
    }
    var userProfileImageUrl: String {
        if _userProfileImageUrl == nil {
            _userProfileImageUrl = ""
        }
        return _userProfileImageUrl
    }
    var descrip: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var tags: String {
        if _tags == nil {
            _tags = ""
        }
        return _tags
    }
    var followers: [[String:String]] {
        if _followers == nil {
            _followers = []
        }
        return _followers
    }
    var followings: [[String:String]] {
        set {
            self._followings = newValue
        }
        get{
            if _followings == nil {
                _followings = []
            }
            return _followings
        }
    }
    var userPostedStrory: [Story]! {
        return _userPostedStrory
    }
    
    var userLikedStory: [Story]! {
        return _userLikedStory
    }
    
    
    init(response: [String:AnyObject]) {
        self._userId = response["user_id"] as! String
        self._userName = response["name"] as! String
        self._description = response["description"] as! String
        self._userProfileImageUrl = response["image"] as! String
        
        if let followersResponseArray = response["followers"] as? [AnyObject] {
            var followersArray = [[String:String]]()
            
            followersResponseArray.forEach({ (follower) in
                let name = follower["name"] as! String
                let imageURL = follower["image"] as! String
                let followerDictionary = ["name":name, "imageURL":imageURL] 
                followersArray.append(followerDictionary)
            })
            self._followers = followersArray
        }
        
        if let followingsResponseArray = response["followings"] as? [AnyObject] {
            var followingsArray = [[String:String]]()
            
            followingsResponseArray.forEach({ (following) in
                let name = following["name"] as! String
                let imageURL = following["image"] as! String
                let followingDictionary = ["name":name, "imageURL":imageURL]
                followingsArray.append(followingDictionary)
            })
            self._followings = followingsArray
        }
        
        if let userPostedStrory = response["MyStory"] as? [Dictionary<String, AnyObject>]{
            for postedStory in userPostedStrory{
                let story = Story(story: postedStory)
                self._userPostedStrory.append(story)
            }
            
        }
        
        if let userCollectedStory = response["StoryCollection"] as? [Dictionary<String, AnyObject>]{
            for collectedStory in userCollectedStory{
                let story = Story(story: collectedStory)
                self._userLikedStory.append(story)
            }
        }

    }
    
    func setUserProperty(userId: String, name: String, description: String, followers: [[String:String]], followings: [[String:String]]) {
        self._userId = userId
        self._userName = name
        self._description = description
        self._followers = followers
        self._followings = followings
    }
}