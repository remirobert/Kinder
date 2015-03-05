//
//  ViewController.swift
//  tindView
//
//  Created by Remi Robert on 04/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RRVoteDelegate {

    var data: Array<ModelCard>! = Array()
    let c = Crackers(url: "http://www.splashbase.co/api/v1/images/random")
    let controller = RRVoteViewController()
    
    func acceptCard(card: ModelCard?) {
        
    }
    
    func cancelCard(card: ModelCard?) {
        
    }

    func fetchData(completion: (()->())?) {
        
        let newCard = Model()
        
        newCard.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://thecatapi.com/api/images/get?format=src&type=gif")!)!)
        newCard.content = "cat"
        NSLog("fetch new data")
        
        self.data.append(newCard)
        
        if self.data.count == 5 {
            completion!()
            return
        }
        else {
            self.fetchData(completion)
        }
        
    }
    
    func signalReload() {
        println("call signal")
        data.removeAll(keepCapacity: false)
        self.fetchData { () -> () in
            self.controller.reloadData()
        }
        println("end signl")
    }
    
    func reloadCard() -> [ModelCard]? {
        NSLog("reload data")
        return data
    }
    
    override func viewDidAppear(animated: Bool) {

        fetchData { () -> () in
            self.controller.delegate = self
            self.presentViewController(self.controller, animated: true, completion: nil)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

