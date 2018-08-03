//
//  Video.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 7/28/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import UIKit

class Video : NSObject {
    var thumbnailImageName : String?
    var title : String?
    var channel : Channel?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
}

class Channel: NSObject {
    var name : String?
    var profileImageName: String?
}
