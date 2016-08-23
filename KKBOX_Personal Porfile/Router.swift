//
//  Router.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://140.122.185.184:8080"
    
    case Full(FullAPI)
    case Auth(AuthAPI)
    case User(UserAPI)
    case Follow(FollowAPI)
    case Playlist(PlaylistAPI)
    case History(HistoryAPI)
    case Album(AlbumAPI)
    case Story(StoryAPI)
    case Artist(ArtistAPI)
    case Song(SongAPI)
    case Like(LikeAPI)
    case Image(ImageAPI)
    
    
    var method: Alamofire.Method {
        switch self {
            
        case .Full(let fAPI):
            switch fAPI {
            case .GetFullInfo(_):
                return .POST
            }
        case .Auth(let aAPI):
            switch aAPI {
            case .Login(_):
                return .POST
            case .Logout:
                return .POST
            }
            
        case .User(let uAPI):
            switch uAPI {
            case .GetSimpleInfo(_):
                return .POST
            case .UpdateInfo(_, _):
                return .POST
            case .GetTrackByTagName(_):
                return .POST
            }
            
        case .Follow(let fAPI):
            switch fAPI {
            case .GetFollowers:
                return .POST
            case .GetFollowings:
                return .POST
            case .AddFollowing(_):
                return .POST
            case .DropFollowing(_):
                return .POST
            case .isFollowing(_):
                return .POST
            }
            
        case .Playlist(let pAPI):
            switch pAPI {
            case .GetPlaylist:
                return .POST
            case .AddPlaylist(_):
                return .POST
            }
            
        case .History(let hAPI):
            switch hAPI {
            case .GetHistory:
                return .POST
            case .AddHistory(_):
                return .POST
            }
            
        case .Album(let aAPI):
            switch aAPI {
            case .GetAlbumCollection:
                return .POST
            case .CollectAlbum(_):
                return .POST
            }
            
        case .Story(let sAPI):
            switch sAPI {
            case .GetMyStory:
                return .POST
            case .GetStoryColection:
                return .POST
            case .CollectStory(_):
                return .POST
            case .AddStory(_, _, _, _):
                return .POST
            case .AddComment(_, _):
                return .POST
            }
            
        case .Artist(let aAPI):
            switch aAPI {
            case .GetArtistCollection:
                return .POST
            case .CollectArtist(_):
                return .POST
            }
            
        case .Song(let sAPI):
            switch sAPI {
            case .CollectTrack(_, _):
                return .POST
            }
        case .Like(let lAPI):
            switch lAPI {
            case .LikeStory(_):
                return .POST
            }
        case .Image(let iAPI):
            switch  iAPI {
            case .GetUserImage(_):
                return .POST
            }
        }
    }
    
    var path: String {
        switch self {
        case .Full(let fAPI):
            switch fAPI {
            case .GetFullInfo(_):
                return "/user/getFullInfo"
            }
        case .Auth(let aAPI):
            switch aAPI {
            case .Login(_):
                return "/login"
            case .Logout:
                return "/logout"
            }
            
        case .User(let uAPI):
            switch uAPI {
            case .GetSimpleInfo(_):
                return "/user/getSimpleInfo"
            case .UpdateInfo(_, _):
                return "/user/updateInfo"
            case .GetTrackByTagName(_):
                return "/user/getTrackByTagName"
            }
            
        case .Follow(let fAPI):
            switch fAPI {
            case .GetFollowers:
                return "/user/getFollowers"
            case .GetFollowings:
                return "/user/getFollowings"
            case .AddFollowing(_):
                return "/user/addFollowing"
            case .DropFollowing(_):
                return "/user/dropFollowing"
            case .isFollowing(_):
                return "/user/isFollowing"
            }
            
        case .Playlist(let pAPI):
            switch pAPI {
            case .GetPlaylist:
                return "/user/getPlaylists"
            case .AddPlaylist(_):
                return "/user/addPlaylist"
            }
            
        case .History(let hAPI):
            switch hAPI {
            case .GetHistory:
                return "/user/getHistory"
            case .AddHistory(_):
                return "/user/addHistory"
            }
            
        case .Album(let aAPI):
            switch aAPI {
            case .GetAlbumCollection:
                return "/user/getAlbumCollection"
            case .CollectAlbum(_):
                return "/user/collectAlbum"
            }
            
        case .Story(let sAPI):
            switch sAPI {
            case .GetMyStory:
                return "/user/getMyStory"
            case .GetStoryColection:
                return "/user/getStoryCollection"
            case .CollectStory(_):
                return "/user/collectStory"
            case .AddStory(_, _, _, _):
                return "/user/addStory"
            case .AddComment(_, _):
                return "/user/addComment"
            }
            
        case .Artist(let aAPI):
            switch aAPI {
            case .GetArtistCollection:
                return "/user/getArtistCollection"
            case .CollectArtist(_):
                return "/user/collectArtist"
            }
            
        case .Song(let sAPI):
            switch sAPI {
            case .CollectTrack(_, _):
                return "/user/collectTrack"
            }
        case .Like(let lAPI):
            switch lAPI {
            case .LikeStory(_):
                return "/user/likeStory"
            }
        case .Image(let iAPI):
            switch iAPI {
            case .GetUserImage(_):
                return "/user/getUserImage"
            }
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        guard let url = NSURL(string: Router.baseURLString) else {
            fatalError("baseURLString cannot cast to url : \(Router.baseURLString)")
        }
        
        let mutableURLRequest = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .Full(let fAPI):
            switch fAPI {
            case .GetFullInfo(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
            
        case .Auth(let aAPI):
            switch aAPI {
            case .Login(let loginInfo):
                let params = ["loginInfo":loginInfo]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            default:
                return mutableURLRequest
            }
            
        case .User(let uAPI):
            switch uAPI {
            case .GetSimpleInfo(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .UpdateInfo(let description, let tags):
                let params = ["description":description, "tags":tags]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .GetTrackByTagName(let tag):
                let params = ["tagName":tag]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
            
        case .Follow(let fAPI):
            switch fAPI {
            case .GetFollowers(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .GetFollowings(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .AddFollowing(let name):
                let params = ["following":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .DropFollowing(let name):
                let params = ["following_id":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .isFollowing(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
            
        case .Playlist(let pAPI):
            switch pAPI {
            case .GetPlaylist(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .AddPlaylist(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
            
        case .History(let hAPI):
            switch hAPI {
            case .GetHistory(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .AddHistory(let trackId):
                let params = ["track_id":trackId]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
            
        case .Album(let aAPI):
            switch aAPI {
            case .GetAlbumCollection(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .CollectAlbum(let albumId):
                let params = ["album_id":albumId]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
            
        case .Story(let sAPI):
            switch sAPI {
            case .GetStoryColection(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .CollectStory(let storyId):
                let params = ["story_id":storyId]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .AddStory(let title, let content, let time, let trackId):
                let params = ["title":title, "content":content, "time":time, "track_id":trackId]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .AddComment(let content, let storyId):
                let params = ["content":content, "story_id":storyId]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            default:
                return mutableURLRequest
            }
            
        case .Artist(let aAPI):
            switch aAPI {
            case .GetArtistCollection(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            case .CollectArtist(let artistId):
                let params = ["artist_id":artistId]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
            
        case .Song(let sAPI):
            switch sAPI {
            case .CollectTrack(let trackId, let playlistId):
                let params = ["track_id":trackId, "playlist_id":playlistId]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
        case .Like(let lAPI):
            switch lAPI {
            case .LikeStory(let storyId):
                let params = ["Story_id":storyId]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
        case .Image(let iAPI):
            switch iAPI {
            case .GetUserImage(let name):
                let params = ["name":name]
                let request = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
                return request
            }
        }
    }
}

enum FullAPI {
    //所有User資訊
    case GetFullInfo(String)
}

enum AuthAPI {
    //要先登入才能使用其他API
    case Login(String)
    case Logout
}

enum UserAPI {
    //拿到使用者資料
    case GetSimpleInfo(String)
    //更改使用者資料
    case UpdateInfo(String,String)
    //拿到使用者風格的歌曲
    case GetTrackByTagName(String)
}

enum FollowAPI {
    //拿到使用者正在追蹤的人
    case GetFollowings(String)
    //拿到追蹤使用者的人
    case GetFollowers(String)
    //新增追蹤人
    case AddFollowing(String)
    //取消追蹤人
    case DropFollowing(String)
    //是否有追蹤
    case isFollowing(String)
}

enum PlaylistAPI {
    //拿到使用者的歌單
    case GetPlaylist(String)
    //新增歌單
    case AddPlaylist(String)
}

enum HistoryAPI {
    //拿到使用者對歌曲的聆聽次數
    case GetHistory(String)
    //增加使用者對歌曲的聆聽次數
    case AddHistory(String)
}

enum AlbumAPI {
    //拿到使用者收藏的專輯
    case GetAlbumCollection(String)
    //收藏專輯
    case CollectAlbum(String)
}

enum StoryAPI {
    //拿到使用者收藏的故事
    case GetStoryColection(String)
    //拿到使用者自己的故事
    case GetMyStory
    //新增故事
    case AddStory(String, String, String, String)
    //收藏故事
    case CollectStory(String)
    //在故事底下新增留言
    case AddComment(String, String)
}

enum ArtistAPI {
    //拿到使用者收藏的藝人
    case GetArtistCollection(String)
    //收藏藝人
    case CollectArtist(String)
}

enum SongAPI {
    //收藏歌曲
    case CollectTrack(String, String)
}

enum LikeAPI {
    //對故事按讚
    case LikeStory(String)
}

enum ImageAPI {
    //拿使用者頭貼
    case GetUserImage(String)
}