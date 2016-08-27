//
//  CommentVC.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/14.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class CommentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var profileImgNameContainerView: UIView!
    var profileImgNameContainerViewHeight: Float!

    @IBOutlet weak var favoriteCommentPlayContainerView: UIView!
    
    @IBOutlet weak var trackContainerView: UIView!
    
    
    @IBOutlet weak var likeNumLabel: UILabel!
    
    @IBOutlet weak var commentsNumLabel: UILabel!
    
    @IBOutlet weak var likeImg: UIImageView!
    
    
    var scrollViewContainerViewPoint: CGRect!
    var trackContainerViewPoint: CGRect!
    
    
    var comments = [Comment]()
    var story: Story!
    var topTwoComments = [Comment]()
    var commentHeaderView = CommentHeaderView.instanceFromNib()
    var postComment: Comment!
    var commentSecondHeaderView = CommentSecondHeaderView.instanceFromNib()

    
    let fullScreenSize = UIScreen.mainScreen().bounds.size

    
    convenience init(comments: [Comment], story: Story ){
        self.init(nibName: "CommentVC", bundle: nil)
        self.story = story
        self.comments = comments
        self.postComment = Comment(story: story)
        if !topTwoComments.isEmpty{
            topTwoComments.removeAll()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.trackContainerViewPoint = trackContainerView.frame
       
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 420
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.separatorColor = UIColor.clearColor()

        let headerview = UIView(frame: CGRectMake(0,0, 320, 182 + 50))
        self.tableView.backgroundView = UIView(frame: CGRectMake(0,0, 320, 232))
        headerview.backgroundColor = UIColor.clearColor()
        
        
        var frame = commentHeaderView.frame
        frame.origin.y = CGRectGetHeight(headerview.bounds) - 50
        commentHeaderView.frame = frame

        headerview.addSubview(commentHeaderView)
        
        let trackView = UIImageView(frame: CGRect(x: 88, y: 18, width: 145, height: 145))
    
        self.likeNumLabel.text = "\(self.story.storyLikeNum)" + " 人共鳴"
        self.commentsNumLabel.text = "\(self.story.storyComments.count)" + " 則留言"
        
        let albumImageURL = NSURL(string: story.storySongCoverUrl)
        let albumImageData = NSData(contentsOfURL: albumImageURL!)
        print(albumImageURL)
        
        if let imgData = albumImageData{
            trackView.image = UIImage(data: imgData)
        }
        
        

    
    
        self.tableView.backgroundView?.addSubview(trackView)
        self.tableView.backgroundView?.backgroundColor = UIColor.whiteColor()
        self.tableView.tableHeaderView = headerview
        
        let nib1 = UINib(nibName: "CommentStoryTitleViewCell", bundle: nil)
        tableView.registerNib(nib1, forCellReuseIdentifier: "CommentStoryTitleViewCell")
        
        let nib2 = UINib(nibName: "CommentRespondCell", bundle: nil)
        tableView.registerNib(nib2, forCellReuseIdentifier: "CommentRespondCell")
        
        let nib3 = UINib(nibName: "MusicPostTableViewCell", bundle: nil)
        tableView.registerNib(nib3, forCellReuseIdentifier: "MusicPostTableViewCell")
        
        
        
        
        
        // 導覽列標題
        self.title = "故事標題"
        
        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        
        // 導覽列左邊按鈕
        let rightItem1 = UIBarButtonItem(
            image: UIImage(named: "icon_comment"),
            style:.Plain ,
            target:self ,
            action: nil)
        
        
        
        let rightItem2 = UIBarButtonItem(
            image: UIImage(named: "icon_favorite_normal"),
            style:.Plain ,
            target:self ,
            action: nil)
 
        self.navigationItem.rightBarButtonItems = [rightItem1, rightItem2]
        
        // Get the first button's image
        var view1Img:UIImage = UIImage(named: "icon_comment")!
        
        // Create the first button
        var view1:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: view1Img.size.width, height: view1Img.size.height))
        
        // Get the second button's image
        var view2Img:UIImage = UIImage(named: "icon_favorite_normal")!
        
        // Create the second button
        var view2:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: view2Img.size.width, height: view2Img.size.height))
        
        // Create two UIBarButtonItems
        let item1:UIBarButtonItem = UIBarButtonItem(customView: view1)
        let item2:UIBarButtonItem = UIBarButtonItem(customView: view2)
        
        // Set 26px of fixed space between the two UIBarButtonItems
        var fixedSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        fixedSpace.width = 10.0
        
        // Set -7px of fixed space before the two UIBarButtonItems so that they are aligned to the edge
        let negativeSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        negativeSpace.width = -7.0

        self.navigationItem.rightBarButtonItems = [negativeSpace, rightItem1, fixedSpace, rightItem2]

    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        case 2:
            return 1
        case 3:
            if self.comments.count > 0{
              return 2
            }
            return 0
        default:
            return 0
            
            
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("MusicPostTableViewCell", forIndexPath: indexPath) as! MusicPostTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            cell.selectionStyle = .None
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentStoryTitleViewCell") as! CommentStoryTitleViewCell
            if let text = cell.txt as? String{
                print(text)
                self.postComment.commentContent = text
            }
            
            if story != nil{
                cell.configureCell(story)
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentRespondCell") as! CommentRespondCell
            if self.comments.count > 0{
                for comment in comments {
                    cell.configureCell(comment)
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentRespondCell") as! CommentRespondCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        commentHeaderView.configureView(story)
            if section == 3 {
            //commentSecondHeaderView = CommentSecondHeaderView.instanceFromNib()
            return commentSecondHeaderView
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 226
        case 1:
            return 0
        case 2:
            return 420
        case 3:
            return 154
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }else if section == 3{
            return 50
        }
        return 0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let headerView = self.tableView.tableHeaderView else {
            return
        }
        let offset = scrollView.contentOffset.y
        var frame = commentHeaderView.frame
        if offset > CGRectGetHeight(headerView.bounds) - 50 {
            frame.origin.y = offset
        } else {
            frame.origin.y = CGRectGetHeight(headerView.bounds) - 50
        }
        commentHeaderView.frame = frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    
    //MARK: To make scrollViewContainer move to the top
    
    }
        
        
    @IBAction func postBtn(sender: UIButton) {
       // self.postComment.commentContent = self.commentTextField.text!
        print(self.postComment.commentContent)
        
        self.postCommentToServer(self.postComment)
        
        print("")
    }
    
    func configurePostComment(){
       // self.postComment.commentContent = self.postCommentTextField.text!
        
    }
    
    
    
    //MARK: -http Request
    func postCommentToServer(comment: Comment){
        ServerManager.addComment(commentContent: comment.commentContent, storyId: story.storyId, completion: {
            print("post Success")
        }) { (error) in
                
        }
        
    }

}
