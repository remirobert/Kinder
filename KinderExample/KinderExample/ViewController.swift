//
//  ViewController.swift
//  tindView
//
//  Created by Remi Robert on 04/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KinderDelegate {
    
    var data: Array<KinderModelCard>! = Array()
    let controller = KinderViewController()
    
    func acceptCard(card: KinderModelCard?) {
        
    }
    
    func cancelCard(card: KinderModelCard?) {
        
    }
    
    func fetchData(int: Int, completion: (()->())?) {
        
        let newCard = Model()
        
        if let url = NSURL(string: "http://thecatapi.com/api/images/get?format=src&type=gif") {
            if let data = NSData(contentsOfURL: url) {
                newCard.image = UIImage(data: data)
                newCard.content = "cat"
                newCard.desc = "Image from the thecatapi.com\nUpdated daily with hundreds of new Kittys"
                self.data.append(newCard)
                NSLog("fetch new data")
            }
            else {
                completion!()
                return
            }
        }
        else {
            completion!()
            return
        }
        
        
        if self.data.count == 5 {
            completion!()
            return
        }
        else {
            self.fetchData(0, completion)
        }
        
    }
    
    func signalReload() {
        println("call signal")
        data.removeAll(keepCapacity: false)
        
        self.fetchData(0, completion: { () -> () in
            self.controller.reloadData()
        })
        
        println("end signl")
    }
    
    func reloadCard() -> [KinderModelCard]? {
        NSLog("reload data")
        return data
    }
    
    override func viewDidAppear(animated: Bool) {
        
        fetchData(0, completion: { () -> () in
            self.controller.delegate = self
            self.presentViewController(self.controller, animated: true, completion: nil)
        })
        
    }    
}

