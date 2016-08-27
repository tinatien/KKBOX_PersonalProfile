//
//  StoryViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/22.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userName: String?
    var myStories = [Story]()
    //    var commentVC: CommentVC!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib1 = UINib(nibName: "DynamicPostWallCell", bundle: nil)
        tableView.registerNib(nib1, forCellReuseIdentifier: "DynamicPostWallCell")
    }

    
    
    //MARK: - HTTP Request
    func getMyPostInfo() {
        if !self.myStories.isEmpty{
            self.myStories.removeAll()
        }
        ServerManager.getFullInfo(username: userName!, completion: { (user) in
            for postedStory in user.userPostedStrory{
                print(self.myStories)
                self.myStories.append(postedStory)
            }
            self.tableView.reloadData()}
            ,failure: { (error) in
                print("error")
        })
    }
    
    
    
    //MARK: -TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myStories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let storyCell = tableView.dequeueReusableCellWithIdentifier("DynamicPostWallCell") as! DynamicPostWallCell
        
        if self.myStories.count > 0{
            let story = self.myStories[indexPath.row]
            storyCell.configureCell(story)
        }
        return storyCell
    }
    
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    //            var comments = [Comment]()
    //
    //            comments = followingsStories[indexPath.row].storyComments
    //            commentVC = CommentVC.init(comments: comments, story: followingsStories[indexPath.row])
    //            self.navigationController?.pushViewController(commentVC, animated: true)
    //        }
    //    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 252
    }
}

