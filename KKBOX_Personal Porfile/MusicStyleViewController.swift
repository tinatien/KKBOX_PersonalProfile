//
//  MusicStyleViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/26.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class MusicStyleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var musicStyleSegmentedControl: ProfileSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalSongsLabel: UILabel!
    
    let headerView = PlayHeaderView.instanceFromNib()
    var songsArray: [Song]!
    
    
    convenience init(songsArray: [Song]) {
        self.init(nibName: "MusicStyleViewController", bundle: nil)
        self.songsArray = songsArray
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
        addTableheaderViewAndBackgroundView(0)
        tableView.registerNib(UINib(nibName: "MusicRatingTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicRatingTableViewCell")
    }
    
    func addTableheaderViewAndBackgroundView(numberOfIndex: Int) {
        let headerView = UIView(frame: CGRectMake(0, 0, 320,160))
        headerView.backgroundColor = UIColor.clearColor()
        if numberOfIndex == 0 {
            let image = UIImage(named: "style_icon_jazz")
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRectMake((headerView.bounds.size.width - 60)/2, (headerView.bounds.size.height - 60)/2, 60, 60)
            headerView.addSubview(imageView)
        } else if numberOfIndex == 1 {
                let image = UIImage(named: "style_icon_country")
                let imageView = UIImageView(image: image!)
                imageView.frame = CGRectMake((headerView.bounds.size.width - 60)/2, (headerView.bounds.size.height - 80)/2, 60, 80)
                headerView.addSubview(imageView)
        } else if numberOfIndex == 2 {
                let image = UIImage(named: "style_icon_rock")
                let imageView = UIImageView(image: image!)
                imageView.frame = CGRectMake((headerView.bounds.size.width - 60)/2, (headerView.bounds.size.height - 60)/2, 60, 60)
                headerView.addSubview(imageView)
        }
        
        
        let song = songsArray[0]
        let imageURLString = song.album?.imageURL
        let imageURL = NSURL(string: imageURLString!)
        let imageData = NSData(contentsOfURL: imageURL!)
        let image = UIImage(data: imageData!)
        
        let backgroundImageView = BackgroundImageView(frame: headerView.bounds)
        backgroundImageView.addImageView(image!)
        
        
        self.tableView.backgroundView = UIView(frame: CGRectMake(0, 0, 320, 160))
        self.tableView.backgroundView?.backgroundColor = UIColor(red: 224/255, green: 226/255, blue: 230/255, alpha: 1)
        self.tableView.backgroundView?.addSubview(backgroundImageView)
        self.tableView.tableHeaderView = headerView
    }
    
    func initUI() {
        let backButton = BackButton()
        backButton.InitUI()
        backButton.addTarget(self, action: #selector(backButtonTapped), forControlEvents: .TouchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.customView = backButton
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        self.title = "喜愛曲風"
        musicStyleSegmentedControl.initUI()
    }
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    
    //MARK: - HTTP Request
    func getMusicStyleSongs(numberOfTab: Int) {
        switch numberOfTab {
        case 0:
            ServerManager.getTrackByTagName(tagName: "爵士", completion: { (songs) in
                self.songsArray = songs
                self.tableView.reloadData()
                }, failure: { (error) in
                    print("Tab0 getTrackByTagName error : \(error)")
            })
        case 1:
            ServerManager.getTrackByTagName(tagName: "鄉村", completion: { (songs) in
                self.songsArray = songs
                self.tableView.reloadData()
                }, failure: { (error) in
                    print("Tab1 getTrackByTagName error: \(error)")
            })
        case 2:
            ServerManager.getTrackByTagName(tagName: "搖滾", completion: { (songs) in
                self.songsArray = songs
                self.tableView.reloadData()
                }, failure: { (error) in
                    print("Tab2 getTrackByTagName error :\(error)")
            })
        default:
            break
        }
    }
    
    
    
    //MARK: - Action
    @IBAction func segmentedControlTapped(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0:
            ServerManager.getTrackByTagName(tagName: "爵士", completion: { (songs) in
                self.songsArray = songs
                self.addTableheaderViewAndBackgroundView(0)
                self.tableView.reloadData()
                }, failure: { (error) in
                    print("Tab0 getTrackByTagName error : \(error)")
            })
        case 1:
            ServerManager.getTrackByTagName(tagName: "鄉村", completion: { (songs) in
                self.songsArray = songs
                self.addTableheaderViewAndBackgroundView(1)
                self.tableView.reloadData()
                }, failure: { (error) in
                    print("Tab1 getTrackByTagName error: \(error)")
            })
        case 2:
            ServerManager.getTrackByTagName(tagName: "流行", completion: { (songs) in
                self.songsArray = songs
                self.addTableheaderViewAndBackgroundView(2)
                self.tableView.reloadData()
                }, failure: { (error) in
                    print("Tab2 getTrackByTagName error :\(error)")
            })
        default:
            break
        }
    }
    
    
    
    //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        if songsArray.count != 0 {
            count = songsArray.count
        }
        return count!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            songsArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if songsArray.count != 0 {
            self.totalSongsLabel.text = "\(songsArray.count) Songs"
            let song = songsArray[indexPath.row]
            let songCell = self.tableView.dequeueReusableCellWithIdentifier("MusicRatingTableViewCell", forIndexPath: indexPath) as! MusicRatingTableViewCell
            songCell.configCell(song)
            songCell.ratingNumberLabel.text = "\(indexPath.row+1)"
            cell = songCell
        }
        return cell!
    }
}
