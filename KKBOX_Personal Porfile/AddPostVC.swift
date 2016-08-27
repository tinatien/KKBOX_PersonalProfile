//
//  AddPostVCViewController.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/16.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController {

    @IBOutlet weak var searchTrackView: UIView!
    
    @IBOutlet weak var textFieldView: UITextView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var beforeAddPostTrackView = BeforeAddPostTrackView.instanceFromNib()
    var afterAddPostTrackView = AfterAddPostTrackView.instanceFromNib()
    
    var selectedSong: Song!
    
    convenience init(song: Song){
        self.init(nibName: "AddPostVC", bundle: nil)
        self.selectedSong = song
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beforeAddPostTrackView.textField.delegate = self
        
        afterAddPostTrackView.tag = 101
        
        self.textFieldView.delegate = self
        self.textFieldView.text = "想些什麼..."
        self.textFieldView.textColor = UIColor.lightGrayColor()
        self.textFieldView.font = UIFont(name: "PingFang TC" , size: 12)

        
    }

    override func viewWillAppear(animated: Bool) {
        
    
        self.searchTrackView.addSubview(beforeAddPostTrackView)
        beforeAddPostTrackView.tag = 100

        if let song = selectedSong{
            self.removeSubview()
            self.searchTrackView.addSubview(afterAddPostTrackView)
            afterAddPostTrackView.center = CGPointMake(searchTrackView.frame.size.width  / 2, searchTrackView.frame.size.height / 2)
           
            afterAddPostTrackView.configureView(self.selectedSong)
            self.selectedSong = nil
            
        }
    
        
        
        
    }
    
    func removeSubview(){
        print("Start remove sibview")
        for subView in self.searchTrackView.subviews{
            print(subView.tag)
            if subView.tag == 100{
                subView.removeFromSuperview()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension AddPostVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        let addStoryVC = AddStoryVC.init(nibName: "AddStoryVC", bundle: nil)
        self.navigationController?.pushViewController(addStoryVC, animated: true)
        
        textField.resignFirstResponder()
    }
}


//為TextView創造placeholder的效果
extension AddPostVC: UITextViewDelegate{
    
    
    func textViewDidBeginEditing(textView: UITextView) {
                if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "想些什麼..."
            textView.textColor = UIColor.lightGrayColor()
        }
    }
}



