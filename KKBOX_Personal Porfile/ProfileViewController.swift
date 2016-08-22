//
//  ProfileViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/18.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var backgroundProfileImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var musicTagLabel1: UILabel!
    @IBOutlet weak var musicTagLabel2: UILabel!
    @IBOutlet weak var musicTagLabel3: UILabel!
    @IBOutlet weak var personalMusicRatingButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fansNumberLabel: UILabel!
    @IBOutlet weak var followingsNumberLabel: UILabel!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var profileSegmentedControl: ProfileSegmentedControl!
    @IBOutlet weak var contentView: UIView!
    
    var currentViewController: UIViewController?
    lazy var musicVC: MusicViewController = MusicViewController(nibName: "MusicViewController", bundle: nil)
    lazy var storyVC: StoryViewController = StoryViewController(nibName: "StoryViewController", bundle: nil)
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileSegmentedControl.initUI()
        displayCurrentTab(TabIndex.MusicTab.rawValue)
//        self.collectionView.registerNib(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }

    
    //MARK: - Action
    
    @IBAction func personalMusicRatingButtonTapped(sender: AnyObject) {
    
    
    }
    
    @IBAction func followingButtonTapped(sender: AnyObject) {
        
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
