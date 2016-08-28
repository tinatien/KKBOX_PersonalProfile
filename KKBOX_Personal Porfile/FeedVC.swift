//
//  CommentVCViewController.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/12.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var segmentedSelectedIndex = 0
    @IBOutlet weak var segmentedControlOutlet: ProfileSegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var myPostCell = [DynamicPostWallCell]()
    var strangerPostCell = [StrangerDynamicPostWallCell]()
    var followingsStories = [Story]()
    var strangerStories = [StrangerStories]()
    
    
    let nib = UINib(nibName: "DynamicPostWallSaySomethingCell", bundle: nil)
    let nib1 = UINib(nibName: "DynamicPostWallCell", bundle: nil)
    let nib2 = UINib(nibName: "StrangerDynamicPostWallCell", bundle: nil)
    
    var commentVC: CommentVC!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        
       
        
        tableView.registerNib(nib, forCellReuseIdentifier: "DynamicPostWallSaySomethingCell")
        let nib1 = UINib(nibName: "DynamicPostWallCell", bundle: nil)
        tableView.registerNib(nib1, forCellReuseIdentifier: "DynamicPostWallCell")
        

        
        
        
        
        // 導覽列標題
        self.title = "動態"
        
        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        
        // 導覽列左邊按鈕
        let rightButton = UIBarButtonItem(
            image: UIImage(named: "icon_notice"),
            style:.Plain ,
            target:self ,
            action: nil)
        self.navigationItem.rightBarButtonItem = rightButton
        
       
        
        
        
        segmentedControlOutlet.initUI()
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.getMyPostInfo()
        self.getStrangerPostInfo()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    //MARK: -HTTP Request
    func getMyPostInfo() {
        if !self.followingsStories.isEmpty{
            self.followingsStories.removeAll()
        }

        ServerManager.login(userInfo: "kkbox:kkbox", completion: {
            ServerManager.getFullInfo(username: "kkbox", completion: { (user) in
                for following in user.followings{
                    ServerManager.getFullInfo(username: following["name"]!, completion: { (user) in
                        
                        
                        for postedStory in user.userPostedStrory{
                                                self.followingsStories.append(postedStory)
                        }
                        
                        self.tableView.reloadData()
                        }, failure: { (error) in
                            
                    })
                }
                
                }, failure: { (error) in
                    
            })
            
        }) { (error) in
            
        }
        print(self.followingsStories.count)
        
    }
    
    func getStrangerPostInfo() {
        if !self.strangerStories.isEmpty{
            self.strangerStories.removeAll()
        }
        ServerManager.getStoriesTopTwo({ (stories) in
                for story in stories{
                self.strangerStories.append(story)

                }
            self.tableView.reloadData()
            }) { (error) in
                
        }
        
        ServerManager.getStoriesByComments({ (stories) in
                for story in stories{
                    self.strangerStories.append(story)
                
                }
            self.tableView.reloadData()
            }) { (error) in
                
        }
        
        
        
    }
    
    
    
    
    
    //MARK: -TableView
    //這邊為了利用footer height來設定cell的間距，所以設定了每個row 1個section的方式來做
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if segmentedControlOutlet.selectedSegmentIndex == 0{
            return 2
        }
        return 1
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControlOutlet.selectedSegmentIndex == 0{
            if section == 0 {
                return 1
            }
            return self.followingsStories.count
        }else{
            return self.strangerStories.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if segmentedControlOutlet.selectedSegmentIndex == 0{
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("DynamicPostWallSaySomethingCell") as! DynamicPostWallSaySomethingCell
                cell.textfield?.delegate = self
                return cell
            }else{
                let storyCell = tableView.dequeueReusableCellWithIdentifier("DynamicPostWallCell") as! DynamicPostWallCell
                
                if self.followingsStories.count > 0{
                    let story = self.followingsStories[indexPath.row]
                    storyCell.configureCell(story)
                }
                return storyCell
            }
        }
        
        let strangerStoryCell = tableView.dequeueReusableCellWithIdentifier("StrangerDynamicPostWallCell") as! StrangerDynamicPostWallCell
       
        if self.strangerStories.count > 0{
            let story = self.strangerStories[indexPath.row]
            strangerStoryCell.configureCell(story)
            
        }
        return strangerStoryCell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch segmentedControlOutlet.selectedSegmentIndex{
        case 0:
            var comments = [Comment]()
            
            
                comments = followingsStories[indexPath.row].storyComments
                
                
                commentVC = CommentVC.init(comments: comments, story: followingsStories[indexPath.row])
                
                self.navigationController?.pushViewController(commentVC, animated: true)
            
            
        case 1:
            var comments = [Comment]()
            
                comments = strangerStories[indexPath.row].storyComments
                
                commentVC = CommentVC.init(comments: comments, story: strangerStories[indexPath.row])
                
                self.navigationController?.pushViewController(commentVC, animated: true)
            
            
        default:
            return
        
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CELL_SPACING_HEIGHT
    }
    
    // Make the background color show through
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }

    
    @IBAction func segmentedControlIndexChanged(sender: UISegmentedControl) {
        
        switch segmentedControlOutlet.selectedSegmentIndex
        {
        case 0:
            NSLog("My selected")
            
            tableView.registerNib(nib, forCellReuseIdentifier: "DynamicPostWallSaySomethingCell")
            
            
            tableView.registerNib(nib1, forCellReuseIdentifier: "DynamicPostWallCell")
            
            
            tableView.reloadData()
            self.segmentedSelectedIndex = 0
            NSLog("My selected")
        case 1:
            NSLog("Stranger selected")
            //show history view
            
            tableView.registerNib(nib2, forCellReuseIdentifier: "StrangerDynamicPostWallCell")
            tableView.reloadData()
            self.segmentedSelectedIndex = 1

            NSLog("Stranger selected")
            
        default:
            break;
        }
    }
        
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch segmentedControlOutlet.selectedSegmentIndex{
        case 0:
            if indexPath.section == 0 {
                return 56.0
            }
            return 213
        case 1:
            return 252
            
        default:
            return 0
            
        }

  }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toTopBtn(sender: UIButton) {
        let commentVC = CommentVC.init(nibName: "CommentVC", bundle: nil)
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
    
    
    
}

extension FeedVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
            let addPostVC = AddPostVC.init(nibName: "AddPostVC", bundle: nil)
            self.navigationController?.pushViewController(addPostVC, animated: true)
        
            textField.resignFirstResponder()
    }
}
