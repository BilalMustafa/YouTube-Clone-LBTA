//
//  FeedCell.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 8/13/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import Foundation
import UIKit
class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    var cellId = "cellId"
    var videos : [Video]?
    
    func fetchVideos(){
        ApiService.sharedInstance.fetchVideos { (videos) in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        addSubview(collectionView)
        addConstarintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstarintWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return videos?.count ?? 0
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
           cell.video = videos?[indexPath.row]
            return cell
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            let height = (frame.width - 16 - 16) * 9 / 16
            return CGSize(width: self.frame.width, height: height + 16 + 88)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    
}

