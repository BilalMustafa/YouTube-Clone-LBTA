//
//  VideoCell.swift
//  LBTA_Youtube
//
//  Created by Bilal Mustafa on 7/24/18.
//  Copyright © 2018 Bilal Mustafa. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell : BaseCell {
    
    
    var video : Video? {
        didSet{
            titleLabel.text = video?.title
              setupProfileImage()
          
            
            if let channelName = video?.channel?.name, let numberofViews = video?.numberOfViews {
                let numberFormattor = NumberFormatter()
                numberFormattor.numberStyle = .decimal
                
                
                let subtitleText = "\(String(describing: channelName)) * \(String(describing: numberFormattor.string(from: numberofViews)!)) * 2 Years Ago"
                subtitleTextView.text = subtitleText
            }
             setupThumbnailImage()
            
            
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options , attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
           
        }
    }
    
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
          userprofileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage(){
        if let thubmnailImageUrl = video?.thumbnailImageName {
           thumbnailImageView.loadImageUsingUrlString(urlString: thubmnailImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView  = CustomImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "thumb")
        return imageView
    }()
    
    let sepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let userprofileImageView : CustomImageView = {
        let image = CustomImageView()
        
        image.image = UIImage(named: "user")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 22
        image.layer.masksToBounds = true
        return image
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Sample Video - Blank Space"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView : UITextView = {
        let textView = UITextView()
        textView.text  = "SampleVEVO - 1,604,687,607 views * 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
   
    var titleLabelHeightConstraint : NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        addSubview(thumbnailImageView)
        addSubview(sepratorView)
        addSubview(userprofileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstarintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstarintWithFormat(format: "H:|-16-[v0(44)]", views: userprofileImageView)
        
        //vertical constraints
        addConstarintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userprofileImageView, sepratorView)
        
        addConstarintWithFormat(format: "H:|[v0]|", views: sepratorView)
        
        //top
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userprofileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        
        addConstraint(titleLabelHeightConstraint!)
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userprofileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}

