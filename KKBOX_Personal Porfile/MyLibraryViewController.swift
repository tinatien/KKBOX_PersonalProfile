//
//  MyLibraryViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/18.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class MyLibraryViewController: UIViewController {

    var profileVC: ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func profileGestureTapped(sender: AnyObject) {
        profileVC = ProfileViewController.init(nibName: "ProfileViewController", bundle: nil)
        self.showViewController(profileVC, sender: self)
    }



}
