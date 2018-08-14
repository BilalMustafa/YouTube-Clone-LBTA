//
//  Video.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 7/28/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import UIKit

struct Video : Decodable {
    let title : String?
    let number_of_views : Int?
    let thumbnail_image_name : String?
    let channel : Channel?
    let duration : Int?
}

struct Channel: Decodable {
    let name : String?
    let profile_image_name : String?
    
}
