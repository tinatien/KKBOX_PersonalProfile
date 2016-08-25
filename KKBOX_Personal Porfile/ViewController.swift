//
//  ViewController.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/25.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

var str = "Hello, playground"


class MyView : UIView {
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        UIColor.yellowColor().set()
        UIBezierPath(rect: self.bounds).fill()
        let image = [#Image(imageLiteral: "joe.jpg")#]
        image.drawInRect(self.bounds)
    }
}


class LyricsTableViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lyrrcs"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.separatorColor = UIColor.whiteColor()
        
        
        let headerview = UIView(frame: CGRectMake(0,0, 380, 250))
        headerview.backgroundColor = UIColor.clearColor()
        let myView = MyView(frame: headerview.bounds)
        self.tableView.backgroundView = UIView(frame: CGRectMake(0,0, 380, 250 - 44))
        self.tableView.backgroundView?.addSubview(myView)
        self.tableView.backgroundView?.backgroundColor = UIColor.whiteColor()
        self.tableView.tableHeaderView = headerview
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        cell.textLabel!.text = "ahdsajmdklajdkladjalkdsja"
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UISegmentedControl(items: ["1", "2"])
            return view
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 44
        }
        return 0
    }
    
    
    
}



let controller = LyricsTableViewController(style: .Plain)
let nav = UINavigationController(rootViewController: controller)