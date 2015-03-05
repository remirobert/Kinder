//
//  RRVoteViewController.swift
//  tindView
//
//  Created by Remi Robert on 04/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

extension UIButton {
    func hideButtonAnimation(centerPosition: CGPoint) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2,
            options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                self.frame.size = CGSizeMake(75, 75)
                self.frame.origin = centerPosition
        }, completion: nil)
    }
    
    func displayButtonAnimation(centerPosition: CGPoint) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
            options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                self.frame.size = CGSizeMake(100, 100)
                self.frame.origin = centerPosition
            }, completion: nil)
    }
}

protocol RRVoteDelegate {
    func acceptCard(card: ModelCard?)
    func cancelCard(card: ModelCard?)
    func signalReload()
    func reloadCard() -> [ModelCard]?
}

class RRVoteViewController: UIViewController {
    
    private var dataCards: Array<ModelCard>! = Array()
    private var isAccept: Bool = false
    private var isCancel: Bool = false
    private var recogniserGesture: UIGestureRecognizer!
    var delegate: RRVoteDelegate?

    lazy var acceptButton: UIButton! = {
        let button = UIButton(frame: CGRectMake(self.view.frame.size.width - 95, self.view.frame.size.height - 95, 75, 75))
        button.setImage(UIImage(named: "accept")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        button.tintColor = UIColor(red:0.33, green:0.84, blue:0.41, alpha:1)
        return button
    }()

    lazy var infoButton: UIButton! = {
        let button = UIButton()
        button.frame.size = CGSizeMake(50, 50)
        button.center = CGPointMake(self.view.center.x, self.acceptButton.center.y)
        button.setImage(UIImage(named: "info")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        button.tintColor = UIColor.grayColor()
        return button
    }()

    lazy var cancelButton: UIButton! = {
        let button = UIButton(frame: CGRectMake(20, self.view.frame.size.height - 95, 75, 75))
        button.setImage(UIImage(named: "cancel")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        button.tintColor = UIColor(red:0.99, green:0.24, blue:0.22, alpha:1)
        return button
    }()
    
    private var cards: Array<CardView> = Array()
    
    func reloadData() {
        
        
        
        if let data = self.delegate?.reloadCard() {
            for currentData in data {
                dataCards.append(currentData)
            }
        }
    }
    
    private func initStyleCardView(index: Int) {
        switch index {
        case 0:
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
                options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                self.cards[0].size = CGSizeMake(self.view.frame.size.width - 40, self.view.frame.size.width + 20)
                self.cards[0].center = CGPointMake(self.view.center.x, self.view.center.y - 50)
                self.cards[0].alpha = 1
        }, completion: nil)
            cards[0].addGestureRecognizer(recogniserGesture)
        case 1:
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
                options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                self.cards[1].size = CGSizeMake(self.view.frame.size.width - 55, self.view.frame.size.width + 5)
                self.cards[1].center = CGPointMake(self.view.center.x, self.view.center.y - 50 + 20)
                self.cards[1].alpha = 0.75
            }, completion: nil)
        case 2:
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
                options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                self.cards[2].size = CGSizeMake(self.view.frame.size.width - 65, self.view.frame.size.width - 5)
                self.cards[2].center = CGPointMake(self.view.center.x, self.view.center.y - 50 + 40)
                self.cards[2].alpha = 0.5
                }, completion: nil)
        default: return
        }
    }
    
    private func addNewCard() {
        
        for var index = cards.count; index < 3; index++ {
            if dataCards.count > 0 {
                var newCard = CardView(size: CGSizeZero)
                
                newCard.size = CGSizeMake(self.view.frame.size.width - 65, self.view.frame.size.width - 5)
                newCard.center = CGPointMake(self.view.center.x, 0)
                newCard.imageContent = dataCards.first?.image
                newCard.titleContent = dataCards.first?.content
                dataCards.removeAtIndex(0)
                cards.append(newCard)
                initStyleCardView(index)
                self.view.addSubview(newCard)
            }
            for (var index = cards.count - 1; index >= 0; index--) {
                self.view.bringSubviewToFront(cards[index])
            }
        }
    }
    
    private func manageCards() {
        if dataCards.count < 3 - self.cards.count + 1 {
            NSLog("call signal reload")
            self.delegate?.signalReload()
            NSLog("call signal reload END")
//            if let data = self.delegate?.reloadCard() {
//                for currentData in data {
//                    dataCards.append(currentData)
//                }
//            }
        }

        cards.removeAtIndex(0)
        for (var index = 0; index < cards.count; index++) {
            initStyleCardView(index)
        }
        
        for (var index = cards.count - 1; index >= 0; index--) {
            self.view.bringSubviewToFront(cards[index])
        }
    }
    
    private func initCardView() {
        for (var index = 0; index <= 2 && index < dataCards.count; index++) {
            var newCard = CardView(size: CGSizeZero)
            
            newCard.imageContent = dataCards[index].image
            newCard.titleContent = dataCards[index].content
            cards.append(newCard)
            initStyleCardView(index)
            self.view.addSubview(cards[index])
        }
        for (var index = cards.count - 1; index >= 0; index--) {
            self.view.bringSubviewToFront(cards[index])
            dataCards.removeAtIndex(index)
        }
    }
    
    @objc private func acceptCardView() {
        if cards.count == 0 {
            return
        }
        acceptButton.displayButtonAnimation(CGPointMake(self.view.frame.size.width - 110, self.view.frame.size.height - 110))
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.acceptButton.hideButtonAnimation(CGPointMake(self.view.frame.size.width - 95, self.view.frame.size.height - 95))
        })
        self.delegate?.acceptCard(dataCards.first)
        var currentCard = cards[0]
        
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 1,
            options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                self.cards[0].frame.origin.x = self.view.frame.size.width
                self.cards[0].alpha = 0
            }) { (anim: Bool) -> Void in
                currentCard.removeFromSuperview()
                self.addNewCard()
        }
        self.manageCards()
    }
    
    @objc private func cancelCardView() {
        if cards.count == 0 {
            return
        }
        cancelButton.displayButtonAnimation(CGPointMake(10, self.view.frame.size.height - 110))
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.cancelButton.hideButtonAnimation(CGPointMake(20, self.view.frame.size.height - 95))
        })
        self.delegate?.cancelCard(dataCards.first)
        var currentCard = cards[0]
        
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
            options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
            self.cards[0].center.x = -self.view.frame.size.width
            }) { (anim: Bool) -> Void in
                currentCard.removeFromSuperview()
                self.addNewCard()
        }
        self.manageCards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recogniserGesture = UIPanGestureRecognizer(target: self, action: "handleGesture:")
        acceptButton.addTarget(self, action: "acceptCardView", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.addTarget(self, action: "cancelCardView", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(acceptButton)
        self.view.addSubview(cancelButton)
        self.view.addSubview(infoButton)
        
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.94, alpha:1)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let data = self.delegate?.reloadCard() {
            for currentCard in data {
                dataCards.append(currentCard)
            }
        }
        initCardView()
    }

    @objc private func handleGesture(recognizer: UIPanGestureRecognizer) {
        
        var pointTranslation = recognizer.translationInView(self.view)
        pointTranslation = CGPointMake(recognizer.view!.center.x + pointTranslation.x, recognizer.view!.center.y + pointTranslation.y)
        
        var marginBotSecond = ((self.view.frame.size.width / 2 - pointTranslation.x) / 7) * ((pointTranslation.x < self.view.center.x) ? 1 : -1)
        var marginTopSecond = ((self.view.frame.size.height / 2 - (pointTranslation.y + 20)) / 7) * ((pointTranslation.y < self.view.center.y) ? 1 : -1)

        var marginBotThird = ((self.view.frame.size.width / 2 - pointTranslation.x) / 4) * ((pointTranslation.x < self.view.center.x) ? 1 : -1)
        var marginTopThird = ((self.view.frame.size.height / 2 - pointTranslation.y) / 4) * ((pointTranslation.y < self.view.center.y) ? 1 : -1)
        
        if pointTranslation.x > self.view.center.x {
            marginBotSecond *= -1
            marginBotThird *= -1
        }
        if pointTranslation.y > self.view.center.y {
            marginTopSecond *= -1
            marginTopThird *= -1
        }
        
        recognizer.view?.center = pointTranslation
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            if 1 % self.cards.count == 1 {
                self.cards[1].center = CGPointMake(pointTranslation.x + marginBotSecond, pointTranslation.y + marginTopSecond)
            }
            if 2 % self.cards.count == 2 {
                self.cards[2].center = CGPointMake(pointTranslation.x + marginBotThird, pointTranslation.y + marginTopThird)
            }
        })
        
        if recognizer.view?.center.x >= self.view.frame.size.width {
            acceptButton.displayButtonAnimation(CGPointMake(self.view.frame.size.width - 110, self.view.frame.size.height - 110))
            isAccept = true
        }
        else {
            acceptButton.hideButtonAnimation(CGPointMake(self.view.frame.size.width - 95, self.view.frame.size.height - 95))
            isAccept = false
        }
        
        if recognizer.view?.center.x <= 0 {
            cancelButton.displayButtonAnimation(CGPointMake(10, self.view.frame.size.height - 110))
            isCancel = true
        }
        else {
            cancelButton.hideButtonAnimation(CGPointMake(20, self.view.frame.size.height - 95))
            isCancel = false
        }
        
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
        if recognizer.state == UIGestureRecognizerState.Ended {
            let velocity = recognizer.velocityInView(self.view)
            
            if isAccept {
                acceptCardView()
            }
            else if isCancel {
                cancelCardView()
            }
            
            if cards.count == 0 {
                return
            }
            
            UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4,
                options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                                        
                    if !self.isAccept && !self.isCancel && recognizer.view != nil {
                        recognizer.view!.center = CGPointMake(self.view.center.x, self.view.center.y - 50)
                    }
                    if 1 % self.cards.count == 1 {
                        self.cards[1].center = CGPointMake(self.view.center.x, self.view.center.y - 50 + 20)
                    }
                    if 2 % self.cards.count == 2 {
                        self.cards[2].center = CGPointMake(self.view.center.x, self.view.center.y - 50 + 40)
                    }

            }, completion: nil)
            
            cancelButton.hideButtonAnimation(CGPointMake(20, self.view.frame.size.height - 95))
            acceptButton.hideButtonAnimation(CGPointMake(self.view.frame.size.width - 95, self.view.frame.size.height - 95))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
