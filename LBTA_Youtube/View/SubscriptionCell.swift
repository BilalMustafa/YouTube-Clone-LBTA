//
//  SubscriptionCell.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 8/13/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeeds { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
