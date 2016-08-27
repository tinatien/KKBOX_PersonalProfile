//
//  FollowerViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/24.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class FollowerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPeopleLabel: UILabel!
    
    var followersArray: [[String:String]]!
    
    
    lazy var profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
    
    convenience init(followersArray: [[String:String]]) {
        self.init(nibName: "FollowerViewController", bundle: nil)
        self.followersArray = followersArray
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "粉絲人數"
        tableView.registerNib(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowerTableViewCell")
        
        let backButton = BackButton()
        backButton.InitUI()
        backButton.addTarget(self, action: #selector(backButtonTapped), forControlEvents: .TouchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem()
        leftBarButtonItem.customView = backButton
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }



   //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followersArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRowAtIndexPath(selectedIndexPath!) as! FollowerTableViewCell
        let followerName = cell.nameLabel.text
        
        profileVC.profileUserName = followerName
        self.showViewController(profileVC, sender: self)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.totalPeopleLabel.text = "\(followersArray.count)位使用者"
        
        let follower = followersArray[indexPath.row]
        let cell = self.tableView.dequeueReusableCellWithIdentifier("FollowerTableViewCell", forIndexPath: indexPath) as! FollowerTableViewCell
        cell.configCell(follower)
        return cell
    }
}
