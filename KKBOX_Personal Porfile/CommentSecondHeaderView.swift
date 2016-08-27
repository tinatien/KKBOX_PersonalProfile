//
//  CommentSecondHeaderViewTableViewCell.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/18.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class CommentSecondHeaderView: UIView{

    class func instanceFromNib() -> CommentSecondHeaderView {
        return UINib(nibName: "CommentSecondHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CommentSecondHeaderView
    }
    
    func configureView() {
        
    }
}
