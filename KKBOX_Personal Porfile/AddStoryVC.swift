//
//  AddStoryVC.swift
//  KKBox_People_Project
//
//  Created by 辛忠翰 on 2016/8/16.
//  Copyright © 2016年 Keynote. All rights reserved.
//

import UIKit

class AddStoryVC:
UIViewController,
UITableViewDelegate,
UITableViewDataSource,
UISearchResultsUpdating,
UISearchBarDelegate,
CustomSearchControllerDelegate  {

    var dataArray = [String]()
    
    var filteredArray = [String]()
    
    var shouldShowSearchResults = false

    var searchController: UISearchController!
    
    var customSearchController: CustomSearchController!
    var feedVC: FeedVC!
    var addPostVC: AddPostVC!
    
    var historySongs = [Song]()
    var selectedSong: Song!
    let nib0 = UINib(nibName: "AddStoryCell", bundle: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    //MARK: -Http Request
    func getHistorySongsInfo() {
        if !self.historySongs.isEmpty{
            self.historySongs.removeAll()
        }
        ServerManager.getTrackByTagName(tagName: "爵士", completion: { (songs) in
            for song in songs{
                self.historySongs.append(song)
            }
            self.tableView.reloadData()
            }) { (error) in
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // 導覽列標題
        self.title = "新增故事"
        
        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        
        // 導覽列左邊按鈕
        
        let rightBarButtonItem = UIBarButtonItem(title: "新增", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.backToLastView))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem

        
        
        tableView.registerNib(nib0, forCellReuseIdentifier: "AddStoryCell")
        self.configureCustomSearchController()
        
    }
    
    override func viewWillAppear(animated: Bool){
        self.getHistorySongsInfo()
        for song in self.historySongs{
            print(song.songAlbumName)
        }
        print("")
        
    }
    func backToLastView(){
        addPostVC = AddPostVC.init(nibName: "AddPostVC", bundle: nil)
        
        self.navigationController?.pushViewController(addPostVC, animated: true)
    }
    
    
    //MARK: -tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AddStoryCell") as! AddStoryCell
        if self.historySongs.count > 0{
            let story = self.historySongs[indexPath.row]
            cell.configureCell(story)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let addStoryHeaderView = AddStoryHeaderView.instanceFromNib()
        return addStoryHeaderView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.historySongs)
        print(indexPath.row)
        
        if self.historySongs.count > 0{
            self.selectedSong = self.historySongs[indexPath.row]
            addPostVC = AddPostVC.init(song: historySongs[indexPath.row])
            self.navigationController?.pushViewController(addPostVC, animated: true)
        }
        
        
    }
    
    
    
    
    
    // MARK: -SearchController
    
    
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(
            searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0,
            tableView.frame.size.width, 50.0),
            searchBarFont: UIFont(name: "Futura", size: 16.0)!,
            searchBarTextColor: UIColor.orangeColor(),
            searchBarTintColor: UIColor.blackColor()
        )
        
        customSearchController.customSearchBar.placeholder = "Search in this awesome bar..."
        tableView.tableHeaderView = customSearchController.customSearchBar
        
        customSearchController.customDelegate = self
    }
    

    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    
    // MARK: UISearchResultsUpdating delegate function
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText:NSString = country
            
            return (countryText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView.reloadData()
    }
    
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
    }
    
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country
            
            return (countryText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView.reloadData()
    }
    
    
    
  }

