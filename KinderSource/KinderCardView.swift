//
//  CardView.swift
//  tindView
//
//  Created by Remi Robert on 04/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class KinderCardView: UIView {

    private var isFliped: Bool = false
    private var isAnimated: Bool = false
    
    private var imageViewContent: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabelContent: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.blackColor()
        label.font = UIFont.boldSystemFontOfSize(17)
        return label
    }()
    
    private lazy var descLabelContent: UITextView = {
        let desc = UITextView()
        desc.editable = false
        desc.font = UIFont.systemFontOfSize(17)
        desc.transform = CGAffineTransformMakeScale(-1, 1)
        desc.backgroundColor = UIColor.clearColor()
        desc.textColor = UIColor.grayColor()
        desc.selectable = false
        return desc
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
    
    var descContent: String! {
        get {
            return descLabelContent.text
        }
        set {
            descLabelContent.text = newValue
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
    
    func flipCard() {
        if isAnimated {
            return
        }
        if isFliped == false {
            descLabelContent.frame.size = CGSizeMake(size.width - 20, size.height - 20)
            UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
                options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                    self.transform = CGAffineTransformMakeScale(-1, 1)
                    self.imageViewContent.alpha = 0
                    self.titleLabelContent.alpha = 0
                    self.descLabelContent.alpha = 1
                    self.isAnimated = true
                }, completion: { (anim:Bool) -> Void in
                    self.isAnimated = false
            })
            isFliped = true
        }
        else {
            UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1,
                options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                    self.transform = CGAffineTransformMakeScale(1, 1)
                    self.imageViewContent.alpha = 1
                    self.titleLabelContent.alpha = 1
                    self.descLabelContent.alpha = 0
                    self.isAnimated = true
                }, completion: { (anim:Bool) -> Void in
                    self.isAnimated = false
            })
            isFliped = false
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
        
        descLabelContent.alpha = 0
        descLabelContent.frame.size = CGSizeMake(size.width - 20, size.height - 20)
        descLabelContent.frame.origin = CGPointMake(0, 10)
        self.addSubview(descLabelContent)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
