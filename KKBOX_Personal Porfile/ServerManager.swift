//
//  ServerManager.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager: NSObject {
    
    //MARK: - FUll
    class func getFullInfo(username name: String, completion:(user: User) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.User(UserAPI.GetFullInfo(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseDictionary = value as? Dictionary<String, AnyObject> else {
                    print("ServerManager cannot cast getFullInfo response value to dictionary type")
                    failure(error: nil)
                    return
                }
                let user = User(response: responseDictionary)
                completion(user: user)
            case .Failure(let error):
                failure(error: error)
            }
        }
    }
    
    
    // MARK: - Auth
    class func login(userInfo info: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Auth(AuthAPI.Login(info))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                failure(error: error)
            }
        }
    }
    
    class func logout(completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Auth(AuthAPI.Logout)
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - User
    class func getSimpleInfo(username name: String, completion:(user: User) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.User(UserAPI.GetSimpleInfo(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseDictionary = value as? [String:AnyObject] else {
                    print("ServerManager cannot cast getSimpleInfo response value to dictionary type")
                    failure(error: nil)
                    return
                }
                
                let userInfo = User(response: responseDictionary)
                
                completion(user: userInfo)
                
            case .Failure(let error):
                print("Get error when call ServerManager.getInfo, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func updateInfo(userDescription description: String, musicTags tags: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.User(UserAPI.UpdateInfo(description, tags))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.updateInfo, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func getTrackByTagName(tagName name: String, completion:(songs: [Song]) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.User(UserAPI.GetTrackByTagName(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseArray = value as? [AnyObject] else {
                    print("ServerManager cannot case getTrackByTagName response value to array type")
                    failure(error: nil)
                    return
                }
                
                var songsArray = [Song]()
                
                responseArray.forEach({ (obj) in
                    if let songObj = obj as? [String:AnyObject] {
                        let song = Song(obj: songObj)
                        songsArray.append(song)
                    }
                })
                
                completion(songs: songsArray)
            case .Failure(let error):
                print("Get error when call ServerManager.getTrackByTagName, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    //MARK: - Follow
    class func getFollowers(userName name: String, completion:(followers: [[String:String]]) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Follow(FollowAPI.GetFollowers(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseArray = value as? [AnyObject] else {
                    print("ServerManager cannot case getFollowers response value to array type")
                    failure(error: nil)
                    return
                }
                
                var followersArray = [[String:String]]()
                
                responseArray.forEach({ (obj) in
                    var followersDictionary = [String:String]()
                    let name = obj["name"] as! String
                    let imageURL = obj["image"] as! String
                    followersDictionary = ["name":name, "imageURL":imageURL]
                    followersArray.append(followersDictionary)
                })
                
                completion(followers: followersArray)
            case .Failure(let error):
                print("Get error when call ServerManager.getFollowers, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func getFollowings(userName name: String,completion:(followings: [AnyObject]) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Follow(FollowAPI.GetFollowings(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseArray = value as? [AnyObject] else {
                    print("ServerManager cannot case getFollowings response value to array type")
                    failure(error: nil)
                    return
                }
                
                var followingsArray = [[String:String]]()
                
                responseArray.forEach({ (obj) in
                    var followingsDictionary = [String:String]()
                    let name = obj["name"] as! String
                    let imageURL = obj["image"] as! String
                    followingsDictionary = ["name":name, "imageURL":imageURL]
                    followingsArray.append(followingsDictionary)
                })
                
                completion(followings: followingsArray)
            case .Failure(let error):
                print("Get error when call ServerManager.getFollowings, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func addFollowing(userName name: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Follow(FollowAPI.AddFollowing(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.addFollowing, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func dropFollowing(userName name: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Follow(FollowAPI.DropFollowing(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.dropFollowing, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func isFollowing(userName name: String, completion:(result: AnyObject) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Follow(FollowAPI.isFollowing(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                completion(result: value)
            case .Failure(let error):
                print("Get error when call ServerManager.isFollowing, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - Playlist
    class func getPlaylist(userName name: String, completion:(playlists: [Playlist]) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Playlist(PlaylistAPI.GetPlaylist(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseArray = value as? [AnyObject] else {
                    print("ServerManager cannot cast getPlaylist response value to array type")
                    failure(error: nil)
                    return
                }
                
                var playlistArray = [Playlist]()
                responseArray.forEach({ (obj) in
                    let playlist = Playlist(obj: obj)
                    playlistArray.append(playlist)
                })
                //
                //                responseArray.forEach({ (obj) in
                //                    var listId = ""
                //                    var listName = ""
                //                    var songsArrayResponse = [AnyObject]()
                //                    let songObj = Song()
                //                    let listObj = Playlist()
                //
                //                    listId = obj["playlist_id"] as! String
                //                    listName = obj["playlist_name"] as! String
                //                    songsArrayResponse = obj["songs"] as! [AnyObject]
                //
                //                    var songArray = [Song]()
                //
                //                    songsArrayResponse.forEach({ (song) in
                //
                //                        var songId = ""
                //                        var songName = ""
                //                        var albumDictionary = [String:AnyObject]()
                //                        var albumId = ""
                //                        var albumName = ""
                //                        var albumImage = ""
                //                        var artistDictionary = [String:AnyObject]()
                //                        var artistId = ""
                //                        var artistName = ""
                //                        var artistImage = ""
                //                        let albumObj = Album()
                //                        let artistObj = Artist()
                //
                //                        songId = song["track_id"] as! String
                //                        songName = song["name"] as! String
                //
                //                        albumDictionary = song["album"] as! [String:AnyObject]
                //                        albumId = albumDictionary["album_id"] as! String
                //                        albumName = albumDictionary["name"] as! String
                //                        if let album_images = albumDictionary["images"] as? [AnyObject] {
                //                            if let images = album_images[ALBUM_IMAGE_URL_INDEX] as? [String:AnyObject] {
                //                                albumImage = images["url"] as! String
                //                            }
                //                        }
                //
                //                        artistDictionary = albumDictionary["artist"] as! [String:AnyObject]
                //                        artistId = artistDictionary["artist_id"] as! String
                //                        artistName = artistDictionary["name"] as! String
                //                        if let artist_images = artistDictionary["images"] as? [AnyObject] {
                //                            if let images = artist_images[ARTIST_IMAGE_URL_INDEX] as? [String:AnyObject] {
                //                                artistImage = images["url"] as! String
                //                            }
                //                        }
                //
                //                        artistObj.setArtistProperty(artistId, artistName: artistName, imageURL: artistImage, albums: nil, songs: nil)
                //                        albumObj.setAlbumProperty(albumId, albumName: albumName, imageURL: albumImage, artist: nil, songs: nil)
                //                        songObj.setSongProperty(songId, songName: songName, album: albumObj, artist: nil)
                //                        songArray.append(songObj)
                //                    })
                //
                //                    listObj.setPlaylistProperty(listId, playlistName: listName, songs: songArray)
                //                    playlistArray.append(listObj)
                //                })
                
                completion(playlists: playlistArray)
            case .Failure(let error):
                print("Get error when call ServerManager.getPlaylist, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func addPlaylist(playlistName name: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Playlist(PlaylistAPI.AddPlaylist(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.addPlaylist, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - History
    //        class func getHistory(completion:() -> Void, failure:(error: NSError) -> Void) {
    //            let api = Router.History(HistoryAPI.GetHistory)
    //
    //            Alamofire.request(api).responseJSON { (response) in
    //                switch response.result {
    //                case .Success(let value):
    //                    print("getHistory response: \(value)")
    //                    completion()
    //                case .Failure(let error):
    //                    failure(error: error)
    //                }
    //            }
    //        }
    
    class func addHistory(songId id: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.History(HistoryAPI.AddHistory(id))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.addHistory, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - Album
    class func getAlbumCollection(userName name: String, completion:(albums: [Album]) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Album(AlbumAPI.GetAlbumCollection(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseArray = value as? [AnyObject] else {
                    print("ServerManager cannot cast getAlbumCollection response value to array type")
                    failure(error: nil)
                    return
                }
                
                var albumsArray = [Album]()
                
                responseArray.forEach({ (obj) in
                    let album = Album(obj: obj)
                    albumsArray.append(album)
                })
                
                //                responseArray.forEach({ (obj) in
                //                    var albumId = ""
                //                    var albumName = ""
                //                    var albumImage = ""
                //                    var artistDictionary = [String:AnyObject]()
                //                    var artistId = ""
                //                    var artistName = ""
                //                    var artistImage = ""
                //                    var songArrayResponse = [AnyObject]()
                //                    var albumSongs = [Song]()
                //                    let albumObj = Album()
                //                    let artistObj = Artist()
                //
                //                    albumId = obj["album_id"] as! String
                //                    albumName = obj["name"] as! String
                //                    if let album_images = obj["images"] as? [AnyObject] {
                //                        if let images = album_images[ALBUM_IMAGE_URL_INDEX] as? [String:AnyObject] {
                //                            albumImage = images["url"] as! String
                //                        }
                //                    }
                //
                //                    artistDictionary = obj["artist"] as! [String:AnyObject]
                //                    artistId = artistDictionary["artist_id"] as! String
                //                    artistName = artistDictionary["name"] as! String
                //                    if let artist_images = artistDictionary["images"] as? [AnyObject] {
                //                        if let images = artist_images[ARTIST_IMAGE_URL_INDEX] as? [String:AnyObject] {
                //                            artistImage = images["url"] as! String
                //                        }
                //                    }
                //
                //                    songArrayResponse = obj["songs"] as! [AnyObject]
                //                    songArrayResponse.forEach({ (song) in
                //                        var songId = ""
                //                        var songName = ""
                //                        let songObj = Song()
                //
                //                        songId = song["track_id"] as! String
                //                        songName = song["name"] as! String
                //                        songObj.setSongProperty(songId, songName: songName, album: nil, artist: nil)
                //                        albumSongs.append(songObj)
                //                    })
                //
                //                    artistObj.setArtistProperty(artistId, artistName: artistName, imageURL: artistImage, albums: nil, songs: nil)
                //                    albumObj.setAlbumProperty(albumId, albumName: albumName, imageURL: albumImage, artist: artistObj, songs: albumSongs)
                //                    albumsArray.append(albumObj)
                //                })
                
                completion(albums: albumsArray)
            case .Failure(let error):
                print("Get error when call ServerManager.getAlbumCollection, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func collectAlbum(albumId id: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Album(AlbumAPI.CollectAlbum(id))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.collectAlbum, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - Story
    class func getMyStory(completion:(stories: [Story]) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Story(StoryAPI.GetMyStory)
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseArray = value as? [AnyObject] else {
                    print("ServerManager cannot cast getMyStory response value to array type")
                    failure(error: nil)
                    return
                }
                
                var storyArray = [Story]()
                
                responseArray.forEach({ (obj) in
                    let story = Story(story: obj as! Dictionary<String, AnyObject>)
                    storyArray.append(story)
                })
                
                completion(stories: storyArray)
            case .Failure(let error):
                print("Get error when call ServerManager.getMyStory, error: \(error)")
                failure(error: error)
            }
        }
    }
    
    class func getStoryCollection(userName name: String, completion:(stories: [Story]) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Story(StoryAPI.GetStoryColection(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseArray = value as? [AnyObject] else {
                    print("ServerManager cannot case getStoryCollection response value to array type")
                    failure(error: nil)
                    return
                }
                
                var storyArray = [Story]()
                
                responseArray.forEach({ (obj) in
                    let story = Story(story: obj as! Dictionary<String, AnyObject>)
                    storyArray.append(story)
                })
                
                completion(stories: storyArray)
            case .Failure(let error):
                print("Get error when call ServerManager.getStoryCollection, error: \(error)")
                failure(error: error)
            }
        }
    }
    
    class func getStoriesTopTwo(completion: (stories: [StrangerStories]) -> Void, failure: (error: NSError?) -> Void){
        let api = Router.Story(StoryAPI.GetStoriesTopTwo)
        Alamofire.request(api).responseJSON { (response) in
            switch response.result{
            case .Success(let value):
                guard let responseArray = value as? [Dictionary<String, AnyObject>] else{
                    print("ServerManager cannot case getStoriesTopTwo response value to array type")
                    failure(error: nil)
                    return
                    
                }
                var stories = [StrangerStories]()
                for respond in responseArray{
                    let story = StrangerStories(story: respond)
                    stories.append(story)
                    
                }
                
                completion(stories: stories)
            case .Failure(let error):
                failure(error: error)
            }
            
        }
        
    }
    
    class func getStoriesByComments(completion: (stories: [StrangerStories]) -> Void, failure: (error: NSError?) -> Void){
        let api = Router.Story(StoryAPI.GetStoriesByComments)
        Alamofire.request(api).responseJSON { (response) in
            switch response.result{
            case .Success(let value):
                guard let responseArray = value as? [Dictionary<String, AnyObject>] else{
                    print("ServerManager cannot case getStoriesByComments response value to array type")
                    failure(error: nil)
                    return
                    
                }
                var stories = [StrangerStories]()
                for respond in responseArray{
                    let story = StrangerStories(story: (respond["story"] as? Dictionary<String, AnyObject>)!)
                    
                    stories.append(story)
                    
                }
                
                completion(stories: stories)
            case .Failure(let error):
                failure(error: error)
            }
            
        }
        
    }
    
    class func getStoriesByFollowings(completion: (stories: [Story]) -> Void, failure: (error: NSError?) -> Void){
        let api = Router.Story(StoryAPI.GetStoriesByFollowings)
        Alamofire.request(api).responseJSON { (response) in
            switch response.result{
            case .Success(let value):
                guard let responseArray = value as? [Dictionary<String, AnyObject>] else{
                    print("ServerManager cannot case getStoriesByFollowings response value to array type")
                    failure(error: nil)
                    return
                    
                }
                var stories = [Story]()
                for respond in responseArray{
                    let story = Story(story: respond)
                    stories.append(story)
                    
                }
                
                completion(stories: stories)
            case .Failure(let error):
                failure(error: error)
            }
            
        }
        
    }
    
    class func collectStory(storyId id: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Story(StoryAPI.CollectStory(id))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.collectStory, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func addStory(storyTitle title: String, storyContent content: String, createTime time: String, songId id: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Story(StoryAPI.AddStory(title, content, time, id))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.addStory, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func addComment(commentContent comment: String, storyId id: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Story(StoryAPI.AddComment(comment, id))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.addComment, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - Artist
    class func getArtistCollection(userName name: String, completion:(artists: [Artist]) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Artist(ArtistAPI.GetArtistCollection(name))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                guard let responseArray = value as? [AnyObject] else {
                    print("ServerManager cannot case getArtistCollection response value to array type")
                    failure(error: nil)
                    return
                }
                
                var artistArray = [Artist]()
                
                responseArray.forEach({ (obj) in
                    let artist = Artist(obj: obj)
                    artistArray.append(artist)
                })
                
                completion(artists: artistArray)
            case .Failure(let error):
                print("Get error when call ServerManager.getArtistCollection, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func collectArtist(artistId id: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Artist(ArtistAPI.CollectArtist(id))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.collectArtist, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - Song
    class func collectTrack(songId id: String, playlistId listId:String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Song(SongAPI.CollectTrack(id, listId))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.collectTrack, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - Like
    class func likeStory(storyId id: String, completion:() -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Like(LikeAPI.LikeStory(id))
        
        Alamofire.request(api).responseJSON { (response) in
            switch response.result {
            case .Success( _):
                completion()
            case .Failure(let error):
                print("Get error when call ServerManager.likeStory, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    
    //MARK: - Image
    class func getUserImage(userName name: String, completion:(imageData: NSData) -> Void, failure:(error: NSError?) -> Void) {
        let api = Router.Image(ImageAPI.GetUserImage(name))
        
        Alamofire.request(api).response { (request, response, data, error) in
            if let imageData = data {
                completion(imageData: imageData)
            } else {
                print("Get error when call ServerManager.getUserImage, error : \(error)")
                failure(error: error)
            }
        }
    }
    
    class func uploadImage(imageData data: NSData, completion:() -> Void, failure:(error: NSError?) -> Void) {
        Alamofire.upload(.POST, "http://140.122.185.184:8080/user/uploadImage", multipartFormData: { (MultipartFormData) in
            MultipartFormData.appendBodyPart(data: data, name: "img",fileName: "kk.jpg" ,mimeType: "multipart/form-data")
            }, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    //                    upload.responseJSON(completionHandler: { (response) in
                    //                        completion()
                    //                    })
                    upload.responseString(completionHandler: { (response) in
                        completion()
                    })
                case .Failure(let encodingError):
                    print("Get error when call ServerManager.uploadImage, error : \(encodingError)")
                }
        })
    }
}
