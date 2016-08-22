//
//  Story.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import Foundation

class Story: NSObject {
    private var _story_id: String!
    private var _title: String!
    private var _content: String!
    private var _time: String!
    private var _song_id: String!
    private var _user_id: String!
    private var _user_name: String!
    
    var stroyId: String {
        if _story_id == nil {
            _story_id = ""
        }
        return _story_id
    }
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    var content: String {
        if _content == nil {
            _content = ""
        }
        return _content
    }
    var time: String {
        if _time == nil {
            _time = ""
        }
        return _time
    }
    var songId: String {
        if _song_id == nil {
            _song_id = ""
        }
        return _song_id
    }
    var userId: String {
        if _user_id == nil {
            _user_id = ""
        }
        return _user_id
    }
    var userName: String {
        if _user_name == nil {
            _user_name = ""
        }
        return _user_name
    }
    
    init(obj: AnyObject) {
        self._story_id = obj["story_id"] as! String
        self._title = obj["title"] as! String
        self._content = obj["content"] as! String
        self._time = obj["time"] as! String
        self._song_id = obj["track_id"] as! String
        self._user_id = obj["user_id"] as! String
        self._user_name = obj["user_name"] as! String
    }
    
    func setStoryProperty(storyId: String, title: String, content: String, time: String, songId: String, userId: String, userName: String) {
        self._story_id = storyId
        self._title = title
        self._content = content
        self._time = time
        self._song_id = songId
        self._user_id = userId
        self._user_name = userName
    }
    
}