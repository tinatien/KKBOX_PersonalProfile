//
//  MusicRatingV2ViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/25.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class MusicRatingV2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalSongsLabel: UILabel!
    
    var songsArray: [Song]!
    let originalHeaderView = OriginalPlayHeaderView.instanceFromNib()
    let headerView = PlayHeaderView.instanceFromNib()
    
    
    convenience init(songsArray: [Song]) {
        self.init(nibName: "MusicRatingV2ViewController", bundle: nil)
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
        addTableheaderViewAndBackgroundView()
        tableView.registerNib(UINib(nibName: "MusicRatingTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicRatingTableViewCell")
    }
    
    func addTableheaderViewAndBackgroundView() {
        let headerView = UIView(frame: CGRectMake(0, 0, 320,160))
        headerView.backgroundColor = UIColor.clearColor()
        let iconImage = UIImage(named: "style_icon_topsong")
        let iconImageView = UIImageView(image: iconImage!)
        iconImageView.frame = CGRectMake((headerView.bounds.size.width - 148)/2, (headerView.bounds.size.height - 64)/2, 148, 64)
        headerView.addSubview(iconImageView)
        
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
        self.title = "聽歌排行榜"
        
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
    }
    
    func noticeButtonTapped(sender: UIButton) {
        
    }
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    //MARK: - TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number: Int?
        number = songsArray.count
        return number!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat?
        height = 65
        return height!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        //dropFirst會讓第0個index為nil，不會往前遞補
        //            let dropSongs = songsArray.dropFirst()
        self.totalSongsLabel.text = "\(songsArray.count) Songs"
        
        let song = songsArray[indexPath.row]
        let songCell = tableView.dequeueReusableCellWithIdentifier("MusicRatingTableViewCell", forIndexPath: indexPath) as! MusicRatingTableViewCell
        songCell.ratingNumberLabel.text = "\(indexPath.row+1)"
        songCell.configCell(song)
        cell = songCell
        
        return cell!
    }
}
