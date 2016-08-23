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
    var artists = [Artist]()
    var playlists = [Playlist]()
    var albums = [Album]()
    
    
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
        // Do any additional setup after loading the view.
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
//            ServerManager.getArtistCollection(userName: userName!, completion: { (artists) in
//                self.artists = artists
//                self.followingArtistCollectionView.reloadData()
//                }, failure: { (error) in
//                    print("getArtistCollection error : \(error) ")
//            })
//            ServerManager.getPlaylist(userName: userName!, completion: { (playlists) in
//                self.playlists = playlists
//                self.playlistCollectionView.reloadData()
//                }, failure: { (error) in
//                    print("getPlaylists error : \(error)")
//            })
            ServerManager.getAlbumCollection(userName: userName!, completion: { (albums) in
                print(albums)
                self.albums = albums
                self.collectedAlbumCollectionView.reloadData()
                }, failure: { (error) in
                    print("getAlbumCollection error : \(error)")
            })
        }
    }
    
    

    //MARK: - Action
    
    //MARK: - CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count: Int?
        if collectionView == musicRatingCollectionView {
            count = self.songs.count
        }
        if collectionView == collectedAlbumCollectionView {
            count = self.albums.count
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
        
        return cell!
    }
}
