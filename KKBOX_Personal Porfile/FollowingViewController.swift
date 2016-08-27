//
//  FollowingViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/24.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class FollowingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPeopleLabel: UILabel!

    var followingsArray: [[String:String]]!
    
    lazy var profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
    
    convenience init(followingsArray: [[String:String]]) {
        self.init(nibName: "FollowingViewController", bundle: nil)
        self.followingsArray = followingsArray
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "關注人數"
        tableView.registerNib(UINib(nibName: "FollowingTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowingTableViewCell")
        
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
        return followingsArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRowAtIndexPath(selectedIndexPath!) as! FollowingTableViewCell
        let followingName = cell.nameLabel.text
        
        profileVC.profileUserName = followingName
        self.showViewController(profileVC, sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.totalPeopleLabel.text = "\(followingsArray.count)位使用者"
        
        let following = followingsArray[indexPath.row]
        let cell = self.tableView.dequeueReusableCellWithIdentifier("FollowingTableViewCell", forIndexPath: indexPath) as! FollowingTableViewCell
        cell.configCell(following)
        return cell
    }
}
