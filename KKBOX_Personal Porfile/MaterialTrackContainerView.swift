//
//  MaterialTrackContainerView.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/16.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class MaterialTrackContainerView: UIView {

    override func awakeFromNib() {
        //make the shadow of our layer
        layer.cornerRadius = 3.0
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.24).CGColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(1.0, 1.0)
    }

}
