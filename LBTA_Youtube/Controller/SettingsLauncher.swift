//
//  SettingsLauncher.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 8/1/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import Foundation
import UIKit

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    @objc func showSettings(){
        //Show Menu
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    
  
    
    @objc func handleDismiss() {
        
        print("Dismiss Called")
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: self.collectionView.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    override init() {
        super.init()
        
    }
    
}
    
    
    


