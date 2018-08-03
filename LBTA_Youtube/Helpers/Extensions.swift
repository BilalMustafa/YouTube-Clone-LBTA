//
//  Extensions.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 7/24/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstarintWithFormat(format: String, views:UIView...){
        var viewsDiectionary = [String:UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDiectionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDiectionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()



class CustomImageView: UIImageView {
    
    
    var imageUrlString : String?
    
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        
        let url = NSURL(string: urlString)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            if error != nil {
                print(error ?? "Undifined Error")
                return
            }
            DispatchQueue.main.async {
                
                let imageToCache  = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                
                
            }
            }.resume()
    }
    
}


