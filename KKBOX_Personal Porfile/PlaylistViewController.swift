//
//  PlaylistViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tie Lin on 2016/8/27.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    @IBOutlet weak var playlistSegmentedControl: ProfileSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPlaylistsLabel: UILabel!
    
    let headerView = PlayHeaderView.instanceFromNib()
    var playlistsArray: [Playlist]!
    
    
    convenience init(playlistsArray: [Playlist]) {
        self.init(nibName: "PlaylistViewController", bundle: nil)
        self.playlistsArray = playlistsArray
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        tableView.registerNib(UINib(nibName: "PlaylistTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaylistTableViewCell")
    }
    
    func initUI() {
        let backButton = BackButton()
        backButton.InitUI()
        backButton.addTarget(self, action: #selector(backButtonTapped), forControlEvents: .TouchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.customView = backButton
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let noticeButton = NoticeButton()
        noticeButton.InitUI()
        noticeButton.addTarget(self, action: #selector(noticeButtonTapped), forControlEvents: .TouchUpInside)
        
        let rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.customView = noticeButton
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.title = "歌單"
        playlistSegmentedControl.initUI()
    }
    
    func noticeButtonTapped(sender: UIButton) {
    
    }
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    //MARK: - HTTP Request
//    func getMusicStyleSongs(numberOfTab: Int) {
//        switch numberOfTab {
//        case 0:
//            ServerManager.getTrackByTagName(tagName: "爵士", completion: { (songs) in
//                self.songsArray = songs
//                self.tableView.reloadData()
//                }, failure: { (error) in
//                    print("Tab0 getTrackByTagName error : \(error)")
//            })
//        case 1:
//            ServerManager.getTrackByTagName(tagName: "鄉村", completion: { (songs) in
//                self.songsArray = songs
//                self.tableView.reloadData()
//                }, failure: { (error) in
//                    print("Tab1 getTrackByTagName error: \(error)")
//            })
//        case 2:
//            ServerManager.getTrackByTagName(tagName: "搖滾", completion: { (songs) in
//                self.songsArray = songs
//                self.tableView.reloadData()
//                }, failure: { (error) in
//                    print("Tab2 getTrackByTagName error :\(error)")
//            })
//        default:
//            break
//        }
//    }
    
    
    
    //MARK: - Action
    @IBAction func segmentedControlTapped(sender: AnyObject) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            ServerManager.getTrackByTagName(tagName: "爵士", completion: { (songs) in
//                self.songsArray = songs
//                self.addTableheaderViewAndBackgroundView(0)
//                self.tableView.reloadData()
//                }, failure: { (error) in
//                    print("Tab0 getTrackByTagName error : \(error)")
//            })
//        case 1:
//            ServerManager.getTrackByTagName(tagName: "鄉村", completion: { (songs) in
//                self.songsArray = songs
//                self.addTableheaderViewAndBackgroundView(1)
//                self.tableView.reloadData()
//                }, failure: { (error) in
//                    print("Tab1 getTrackByTagName error: \(error)")
//            })
//        case 2:
//            ServerManager.getTrackByTagName(tagName: "流行", completion: { (songs) in
//                self.songsArray = songs
//                self.addTableheaderViewAndBackgroundView(2)
//                self.tableView.reloadData()
//                }, failure: { (error) in
//                    print("Tab2 getTrackByTagName error :\(error)")
//            })
//        default:
//            break
//        }
    }
    
    
    
    //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        if playlistsArray.count != 0 {
            count = playlistsArray.count
        }
        return count!
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            playlistsArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if playlistsArray.count != 0 {
            self.totalPlaylistsLabel.text = "\(playlistsArray.count) Playlists"
            let playlist = playlistsArray[indexPath.row]
            let playlistCell = self.tableView.dequeueReusableCellWithIdentifier("PlaylistTableViewCell", forIndexPath: indexPath) as! PlaylistTableViewCell
            playlistCell.configCell(playlist)
            cell = playlistCell
        }
        return cell!
    }
}
