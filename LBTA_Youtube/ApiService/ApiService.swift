//
//  ApiService.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 8/6/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completation : @escaping ([Video]) -> ()){
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completation: completation)
    }
    
   
    func fetchTrendingFeed(completation : @escaping ([Video]) -> ()){
         fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completation: completation)
    }
    
    func fetchSubscriptionFeeds(completation : @escaping ([Video]) -> ()){
         fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completation: completation)
    }
    
    func fetchFeedForUrlString(urlString: String, completation: @escaping ([Video]) -> ()){
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL) {(data, response, error ) in
            if error != nil {
                print(error!)
                return
            }
            guard let data = data else {return}
            do {
                let videos = try JSONDecoder().decode([Video].self, from: data)
                completation(videos)
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
}
