//
//  CommentScrollView.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/14.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class CommentScrollView: UIView {
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CommentScrollView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
}
