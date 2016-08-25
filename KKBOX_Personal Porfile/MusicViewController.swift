//
//  MusicViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var musicRatingCollectionView: UICollectionView!
    @IBOutlet weak var followingArtistCollectionView: UICollectionView!
    @IBOutlet weak var collectedAlbumCollectionView: UICollectionView!
    @IBOutlet weak var playlistCollectionView: UICollectionView!
    @IBOutlet weak var recentlyListenCollectionView: UICollectionView!
    
    var userName: String?
    var songs = [Song]()
    var personalSongs = [Song]()
    var artists = [Artist]()
    var playlists = [Playlist]()
    var albums = [Album]()
    
    lazy var musicRatingVC: MusicRatingViewController = MusicRatingViewController(nibName: "MusicRatingViewController", bundle: nil)
    lazy var musicRatingV2VC: MusicRatingV2ViewController = MusicRatingV2ViewController(nibName: "MusicRatingV2ViewController", bundle: nil)

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.musicRatingCollectionView.registerNib(UINib(nibName: "MusicRatingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MusicRatingCollectionViewCell")
        self.collectedAlbumCollectionView.registerNib(UINib(nibName: "CollectedAlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectedAlbumCollectionViewCell")
        self.playlistCollectionView.registerNib(UINib(nibName: "PlaylistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlaylistCollectionViewCell")
        self.recentlyListenCollectionView.registerNib(UINib(nibName: "RecentlyListenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentlyListenCollectionViewCell")
        self.followingArtistCollectionView.registerNib(UINib(nibName: "FollowingArtistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FollowingArtistCollectionViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - HTTP Request
    func getInfo() {
        if self.userName != nil {
            ServerManager.getTrackByTagName(tagName: "爵士", completion: { (songs) in
                self.songs = songs
                self.musicRatingCollectionView.reloadData()
                }, failure: { (error) in
                    print("getTrackByTagName error : \(error)")
            })
            ServerManager.getArtistCollection(userName: userName!, completion: { (artists) in
                self.artists = artists
                self.followingArtistCollectionView.reloadData()
                }, failure: { (error) in
                    print("getArtistCollection error : \(error) ")
            })
            ServerManager.getPlaylist(userName: userName!, completion: { (playlists) in
                self.playlists = playlists
                self.playlistCollectionView.reloadData()
                }, failure: { (error) in
                    print("getPlaylists error : \(error)")
            })
            ServerManager.getAlbumCollection(userName: userName!, completion: { (albums) in
                self.albums = albums
                self.collectedAlbumCollectionView.reloadData()
                }, failure: { (error) in
                    print("getAlbumCollection error : \(error)")
            })
            ServerManager.getTrackByTagName(tagName: "個人排行榜", completion: { (songs) in
                self.personalSongs = songs
                self.recentlyListenCollectionView.reloadData()
                }, failure: { (error) in
                    print("getTrackByTagName error : \(error)")
            })
        }
    }
    
    
    //MARK: - Action
    @IBAction func musicRatingMoreButtonTapped(sender: AnyObject) {
//        let musicRatingChildVC = MusicRatingViewController.init(songsArray: self.songs)
//        self.navigationController?.pushViewController(musicRatingChildVC, animated: true)
        let musicRatingV2ChildVC = MusicRatingV2ViewController.init(songsArray: self.songs)
        self.navigationController?.pushViewController(musicRatingV2ChildVC, animated: true)
    }
    
    
    
    //MARK: - CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int?
        if collectionView == musicRatingCollectionView {
            count = self.songs.count
        }
        if collectionView == collectedAlbumCollectionView {
            count = self.albums.count
        }
        if collectionView == playlistCollectionView {
            count = self.playlists.count
        }
        if collectionView == recentlyListenCollectionView {
            count = self.personalSongs.count
        }
        if collectionView == followingArtistCollectionView {
            count = self.artists.count
        }
        return count!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var size: CGSize?
        if collectionView == musicRatingCollectionView {
            size = CGSizeMake(134, 174)
        }
        if collectionView == collectedAlbumCollectionView {
            size = CGSizeMake(134, 174)
        }
        if collectionView == playlistCollectionView {
            size = CGSizeMake(134, 174)
        }
        if collectionView == recentlyListenCollectionView {
            size = CGSizeMake(134, 174)
        }
        if collectionView == followingArtistCollectionView {
            size = CGSizeMake(86, 117)
        }
        return size!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        if collectionView == musicRatingCollectionView {
            let song = self.songs[indexPath.item]
            let songCell = self.musicRatingCollectionView.dequeueReusableCellWithReuseIdentifier("MusicRatingCollectionViewCell", forIndexPath: indexPath) as! MusicRatingCollectionViewCell
            songCell.configCell(song)
            cell = songCell
        }
        if collectionView == collectedAlbumCollectionView {
            let album = self.albums[indexPath.item]
            let albumCell = self.collectedAlbumCollectionView.dequeueReusableCellWithReuseIdentifier("CollectedAlbumCollectionViewCell", forIndexPath: indexPath) as! CollectedAlbumCollectionViewCell
            albumCell.configCell(album)
            cell = albumCell
        }
        if collectionView == playlistCollectionView {
            let playlist = self.playlists[indexPath.item]
            let playlistCell = self.playlistCollectionView.dequeueReusableCellWithReuseIdentifier("PlaylistCollectionViewCell", forIndexPath: indexPath) as! PlaylistCollectionViewCell
            playlistCell.configCell(playlist)
            cell = playlistCell
        }
        if collectionView == recentlyListenCollectionView {
            let song = self.personalSongs[indexPath.item]
            let songCell = self.recentlyListenCollectionView.dequeueReusableCellWithReuseIdentifier("RecentlyListenCollectionViewCell", forIndexPath: indexPath) as! RecentlyListenCollectionViewCell
            songCell.configCell(song)
            cell = songCell
        }
        if collectionView == followingArtistCollectionView {
            let artist = self.artists[indexPath.item]
            let artistCell = self.followingArtistCollectionView.dequeueReusableCellWithReuseIdentifier("FollowingArtistCollectionViewCell", forIndexPath: indexPath) as! FollowingArtistCollectionViewCell
            artistCell.configCell(artist)
            cell = artistCell
        }
        return cell!
    }
}
