//
//  ViewController.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 7/3/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos : [Video]?
    
    func fetchVideos(){
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
    
        URLSession.shared.dataTask(with: url! as URL) {(data, response, error ) in
            if error != nil {
                print(error!)
                return
            }
    
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                for dictionary in json as! [[String: AnyObject]] {
                  let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as? [String: AnyObject]
                    let channel = Channel()
                    channel.profileImageName = channelDictionary!["profile_image_name"] as? String
                    channel.name = channelDictionary!["name"] as? String
                    
                    video.channel = channel
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        //The only way to move the title label to the sides 
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32 , height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor  = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        //Registering a cell class with collection view 
        collectionView?.register(VideoCell.self ,forCellWithReuseIdentifier: "cellId" )
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupMenuBar()
        
        
        setupNavBarButtons()
    }
    
    
    func setupNavBarButtons(){
         
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        
        let searchBarBtnItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton,searchBarBtnItem]
    }
    
   
    @objc func handleMore(){
     
        let settingsLauncher = SettingsLauncher()
        settingsLauncher.showSettings()
    }
    
  
    
    @objc func handleSearch(){
        
    }
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    
    
    fileprivate func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstarintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstarintWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }

 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
       cell.video = videos?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: self.view.frame.width, height: height + 16 + 88)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}





