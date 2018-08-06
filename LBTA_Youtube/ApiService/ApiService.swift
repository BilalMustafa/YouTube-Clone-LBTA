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
    
    func fetchVideos(completation : @escaping ([Video]) -> ()){
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        URLSession.shared.dataTask(with: url! as URL) {(data, response, error ) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var videos = [Video]()
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as? [String: AnyObject]
                    let channel = Channel()
                    channel.profileImageName = channelDictionary!["profile_image_name"] as? String
                    channel.name = channelDictionary!["name"] as? String
                    
                    video.channel = channel
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    completation(videos)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }

}
