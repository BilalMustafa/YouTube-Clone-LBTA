//
//  TrendingCell.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 8/13/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
