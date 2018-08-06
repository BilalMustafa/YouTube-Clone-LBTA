//
//  SettingsLauncher.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 8/1/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import Foundation
import UIKit


class Setting: NSObject {
    let name: SettingsName
    let imageName: String
    
    init(name:SettingsName, imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}
enum SettingsName : String {
    case cancel = "Cancel"
    case settings = "Settings"
    case terms = "Terms & Conditions"
    case feedback = "Send FeedBack"
    case help = "Help"
    case switchAccount = "Switch Account"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    let settings: [Setting] = {
        
        return [Setting(name: .settings, imageName: "settings"), Setting(name: .terms, imageName: "privacy"), Setting(name: .feedback, imageName: "feedback"), Setting(name: .help, imageName: "help"), Setting(name: .switchAccount, imageName: "switch_account"), Setting(name: .cancel, imageName: "cancel")]
    }()
    
    var homeController: HomeController?
    
    @objc func showSettings(){
        //Show Menu
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = CGFloat(settings.count) * cellHeight
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

    @objc func handleDismiss(setting : Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed) in
         
            if  setting.name != .cancel {
                self.homeController?.showControllerForSetting(setting: setting)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        let setting = settings[indexPath.row]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
       
        
    }
    
    override init() {
        super.init()
        collectionView.dataSource  = self
        collectionView.delegate = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}
    
    
    


