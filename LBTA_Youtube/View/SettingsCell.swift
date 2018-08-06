//
//  SettingsCell.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 8/4/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import Foundation
import UIKit

class SettingsCell : BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting: Setting? {
        didSet{
            nameLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        addConstarintWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        
        addConstarintWithFormat(format: "V:|[v0]|", views: nameLabel)
        
        addConstarintWithFormat(format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
