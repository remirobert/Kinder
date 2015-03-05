//
//  CardView.swift
//  tindView
//
//  Created by Remi Robert on 04/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class KinderCardView: UIView {

    private lazy var imageViewContent: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabelContent: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.blackColor()
        return label
    }()
    
    var imageContent: UIImage! {
        get {
            return self.imageViewContent.image
        }
        set {
            self.imageViewContent.image = newValue
        }
    }
    
    var titleContent: String! {
        get {
            return self.titleLabelContent.text
        }
        set {
            self.titleLabelContent.text = newValue
            self.titleLabelContent.frame.origin = CGPointMake(10, ((self.frame.size.height - self.frame.size.width) / 2 -
                self.titleLabelContent.frame.size.height / 2) + self.frame.size.width)
        }
    }
    
    var size: CGSize! {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
            self.imageViewContent.frame.size = CGSizeMake(self.frame.width, self.frame.width)
            self.titleLabelContent.frame.size = CGSizeMake(self.frame.size.width - 20, 30)
            self.titleLabelContent.frame.origin = CGPointMake(10, self.frame.size.width + 10)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(size: CGSize) {
        super.init(frame: CGRectMake(0, 0, size.width, size.height))
        self.backgroundColor = UIColor.whiteColor()
        
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1).CGColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.imageViewContent.frame.size = CGSizeMake(size.width, size.width)
        self.addSubview(self.imageViewContent)
        
        self.titleLabelContent.frame.size = CGSizeMake(size.width - 20, 30)
        self.titleLabelContent.frame.origin = CGPointMake(10, size.width + 10)
        self.addSubview(self.titleLabelContent)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
