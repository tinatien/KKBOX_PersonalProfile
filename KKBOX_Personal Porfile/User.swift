//
//  User.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import Foundation

class User: NSObject {
    
    private var _user_id: String!
    private var _name: String!
    private var _imageURL: String!
    private var _description: String!
    private var _tags: String!
    private var _followers: [[String:String]]!
    private var _followings: [[String:String]]!
    
    var userId: String {
        if _user_id == nil {
            _user_id = ""
        }
        return _user_id
    }
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    var imageURL: String {
        if _imageURL == nil {
            _imageURL = ""
        }
        return _imageURL
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
    
    init(response: [String:AnyObject]) {
        self._user_id = response["user_id"] as! String
        self._name = response["name"] as! String
        self._description = response["description"] as! String
        self._imageURL = response["image"] as! String
        
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
    }
    
    func setUserProperty(userId: String, name: String, description: String, followers: [[String:String]], followings: [[String:String]]) {
        self._user_id = userId
        self._name = name
        self._description = description
        self._followers = followers
        self._followings = followings
    }
}