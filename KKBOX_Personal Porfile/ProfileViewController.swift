//
//  ProfileViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/18.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundProfileImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fansNumberLabel: UILabel!
    @IBOutlet weak var followingsNumberLabel: UILabel!
    @IBOutlet weak var musicStyleLabel1: UILabel!
    @IBOutlet weak var musicStyleLabel2: UILabel!
    @IBOutlet weak var musicStyleLabel3: UILabel!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var profileSegmentedControl: ProfileSegmentedControl!
    @IBOutlet weak var contentView: UIView!
    
    var profileUserName: String?
    var followed: Bool!
    var followersArray = [[String:String]]()
    var followingsArray = [[String:String]]()
    
    var currentViewController: UIViewController?
    lazy var musicVC: MusicViewController = MusicViewController(nibName: "MusicViewController", bundle: nil)
    lazy var storyVC: StoryViewController = StoryViewController(nibName: "StoryViewController", bundle: nil)
    lazy var followerVC: FollowerViewController = FollowerViewController(nibName: "FollowerViewController", bundle: nil)
    lazy var followingVC: FollowingViewController = FollowingViewController(nibName: "FollowingViewController", bundle: nil)
    lazy var musicStyleVC: MusicStyleViewController = MusicStyleViewController(nibName: "MusicStyleViewController", bundle: nil)
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        displayCurrentTab(TabIndex.MusicTab.rawValue)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if profileUserName == nil {
            profileUserName = "Jay"
        }
        getUserInfo(jay_login, name: profileUserName!) {}
    }
    
    
    
    //MARK: - InitUI
    func initUI() {
        
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.alwaysBounceVertical = true
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.clipsToBounds = true
        
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
        
        profileSegmentedControl.initUI()
    }
    
    func noticeButtonTapped(sender: UIButton) {
        
    }
    
    func backButtonTapped(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    //MARK: - HTTP Request
    func getUserInfo(loginInfo: String, name: String, completion:() -> Void) {
        ServerManager.login(userInfo: loginInfo, completion: {
            ServerManager.getSimpleInfo(username: name, completion: { (user) in
                let imageURLString = user.imageURL
                let imageURL = NSURL(string: imageURLString)
                let imageData = NSData(contentsOfURL: imageURL!)
                let image = UIImage(data: imageData!)
                
                self.title = user.name
                self.backgroundProfileImageView.image = image
                self.profileImageView.image = image
                self.userNameLabel.text = user.name
                self.descriptionLabel.text = user.descrip
                
                if user.followings.count == 0 {
                    self.followingsNumberLabel.text = "0"
                } else {
                    self.followingsArray = user.followings
                    self.followingsNumberLabel.text = "\(user.followings.count)"
                }
                
                if user.followers.count == 0 {
                    self.followingsNumberLabel.text = "0"
                } else {
                    self.followersArray = user.followers
                    self.fansNumberLabel.text = "\(user.followers.count)"
                }
                
                self.passValueToMusicWall(name, completion: {
                    self.displayCurrentTab(TabIndex.MusicTab.rawValue)
                })
                }, failure: { (error) in
                    print("getSimpleInfo error : \(error)")
            })
            ServerManager.isFollowing(userName: name, completion: { (result) in
                self.followed = result as! Bool
                
                if self.followed != true {
                    let image = UIImage(named: "btn_follow")
                    self.followingButton.setImage(image, forState: .Normal)
                } else {
                    let image = UIImage(named: "btn_follow_actived")
                    self.followingButton.setImage(image, forState: .Normal)
                }
                }, failure: { (error) in
                    print("isFollowing error : \(error)")
            })
        }) { (error) in
            print("login error : \(error)")
        }
    }
    
    func passValueToMusicWall(name: String, completion:() -> Void) {
        let musicChildVC = self.musicVC
        musicChildVC.userName = name
        musicChildVC.getInfo()
        completion()
    }
    
    
    
    //MARK: - Action
    @IBAction func musicStyleGestureTapped(sender: AnyObject) {
        ServerManager.getTrackByTagName(tagName: "爵士", completion: { (songs) in
            self.musicStyleVC = MusicStyleViewController.init(songsArray: songs)
            self.navigationController?.pushViewController(self.musicStyleVC, animated: true)
        }) { (error) in
            
        }
    }
    
    @IBAction func followerGestureTapped(sender: AnyObject) {
        followerVC = FollowerViewController.init(followersArray: self.followersArray)
        self.navigationController?.pushViewController(followerVC, animated: true)
    }
    
    @IBAction func followingGestureTapped(sender: AnyObject) {
        followingVC = FollowingViewController.init(followingsArray: self.followingsArray)
        self.navigationController?.pushViewController(followingVC, animated: true)
    }
    
    @IBAction func followingButtonTapped(sender: AnyObject) {
        if followed != true {
            ServerManager.addFollowing(userName: profileUserName!, completion: {
                self.getUserInfo(jay_login, name: self.profileUserName!, completion: {})
                }, failure: { (error) in})
        } else {
            ServerManager.dropFollowing(userName: self.profileUserName!, completion: {
                self.getUserInfo(jay_login, name: self.profileUserName!, completion: {})
                }, failure: { (error) in})
        }
    }
    
    
    
    //MARK: - SegmentedControl
    func displayCurrentTab(tabIndex: Int) {
        if let vc = viewControllerForSelectedTab(tabIndex) {
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedTab(index: Int) -> UIViewController? {
        var vc: UIViewController?
        
        switch index {
        case TabIndex.MusicTab.rawValue:
            vc = self.musicVC
        case TabIndex.StoryTab.rawValue:
            vc = self.storyVC
        default:
            return nil
        }
        return vc
    }
    
    
    @IBAction func profileSegmentedControlTapped(sender: AnyObject) {
        self.currentViewController?.view.removeFromSuperview()
        self.currentViewController?.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
}
