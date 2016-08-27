//
//  MusicViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var musicRatingTableView: UITableView!
    @IBOutlet weak var followingArtistCollectionView: UICollectionView!
    @IBOutlet weak var collectedAlbumCollectionView: UICollectionView!
    @IBOutlet weak var playlistCollectionView: UICollectionView!
    
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
        
        self.musicRatingTableView.registerNib(UINib(nibName: "MusicRatingTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicRatingTableViewCell")
        self.collectedAlbumCollectionView.registerNib(UINib(nibName: "CollectedAlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectedAlbumCollectionViewCell")
        self.playlistCollectionView.registerNib(UINib(nibName: "PlaylistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlaylistCollectionViewCell")
        self.followingArtistCollectionView.registerNib(UINib(nibName: "FollowingArtistCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FollowingArtistCollectionViewCell")

        self.collectedAlbumCollectionView.showsHorizontalScrollIndicator = false
        self.playlistCollectionView.showsHorizontalScrollIndicator = false
        self.followingArtistCollectionView.showsHorizontalScrollIndicator = false
    }


    
    //MARK: - HTTP Request
    func getInfo() {
        if self.userName != nil {
            ServerManager.getTrackByTagName(tagName: "個人排行榜", completion: { (songs) in
                self.songs = songs
                self.musicRatingTableView.reloadData()
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
        }
    }
    
    
    
    //MARK: - Action
    @IBAction func musicRatingMoreButtonTapped(sender: AnyObject) {
        let musicRatingV2ChildVC = MusicRatingV2ViewController.init(songsArray: self.songs)
        self.navigationController?.pushViewController(musicRatingV2ChildVC, animated: true)
    }
    
    
    
    //MARK: - CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int?
        
        if collectionView == collectedAlbumCollectionView {
            count = self.albums.count
        }
        if collectionView == playlistCollectionView {
            count = self.playlists.count
        }
        if collectionView == followingArtistCollectionView {
            count = self.artists.count
        }
        return count!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var size: CGSize?
        if collectionView == collectedAlbumCollectionView {
            size = CGSizeMake(100, 147)
        }
        if collectionView == playlistCollectionView {
            size = CGSizeMake(100, 147)
        }
        if collectionView == followingArtistCollectionView {
            size = CGSizeMake(74, 109)
        }
        return size!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        
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
        if collectionView == followingArtistCollectionView {
            let artist = self.artists[indexPath.item]
            let artistCell = self.followingArtistCollectionView.dequeueReusableCellWithReuseIdentifier("FollowingArtistCollectionViewCell", forIndexPath: indexPath) as! FollowingArtistCollectionViewCell
            artistCell.configCell(artist)
            cell = artistCell
        }
        return cell!
    }
    
    
    
    //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.musicRatingTableView.dequeueReusableCellWithIdentifier("MusicRatingTableViewCell", forIndexPath: indexPath) as! MusicRatingTableViewCell
        
        if songs.count != 0 {
            let song = self.songs[indexPath.row]
            cell.ratingNumberLabel.backgroundColor = UIColor.whiteColor()
            cell.ratingNumberLabel.text = "\(indexPath.row+1)"
            cell.configCell(song)
        }
        return cell
    }
}
