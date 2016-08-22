//
//  Song.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import Foundation

class Song: NSObject {
    private var _track_id: String!
    private var _song_name: String!
    private var _album: Album?
    private var _artist: Artist?
    
    var trackId: String {
        if _track_id == nil {
            _track_id = ""
        }
        return _track_id
    }
    var songName: String {
        if _song_name == nil {
            _song_name = ""
        }
        return _song_name
    }
    var album: Album? {
        return _album
    }
    var artist: Artist? {
        return _artist
    }
    
    init(obj: AnyObject) {
        self._track_id = obj["track_id"] as! String
        self._song_name = obj["name"] as! String

        if let albumDictionary = obj["album"] as? [String:AnyObject] {
            let album = Album(obj: albumDictionary)
            self._album = album
        }

        if let artistDictionary = obj["artist"] as? [String:AnyObject] {
            let artist = Artist(obj: artistDictionary)
            self._artist = artist
        }
    }

    func setSongProperty(trackId: String, songName: String, album: Album?, artist: Artist?) {
        self._track_id = trackId
        self._song_name = songName
        self._album = album
        self._artist = artist
    }
    
}