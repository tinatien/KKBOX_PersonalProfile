//
//  TableHeaderView.swift
//  KKBOX_Personal Porfile
//
//  Created by Chun Tai on 2016/8/25.
//  Copyright © 2016年 Chun Tai. All rights reserved.
//

import UIKit

class BackgroundImageView: UIView {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
//        let image = UIImage(named: "Profile")
//        let imageView = UIImageView(image: image)
//        imageView.frame = CGRectMake(0, 0, 320, 400)
//        
//        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
//        visualEffectView.frame = imageView.bounds
//        
//        imageView.addSubview(visualEffectView)
//        self.addSubview(imageView)
    }
    
    func addImageView(image: UIImage) {
        let backgroundImageView = UIImageView(image: image)
        backgroundImageView.frame = CGRectMake(0, 0, 320, 400)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visualEffectView.frame = backgroundImageView.bounds
        
        backgroundImageView.addSubview(visualEffectView)
        self.addSubview(backgroundImageView)
    }
}


