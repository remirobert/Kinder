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

    
    func acceptCard(card: ModelCard?) {
        
    }
    
    func cancelCard(card: ModelCard?) {
        
    }

    
    func fetchData(completion: (()->())?) {
     
        c.sendRequest(.GET, blockCompletion: { (data, response, error) -> () in
            //let json = data?.convertToJson() as? NSDictionary
            var error: NSError?
            let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
            println("response : \(response)")
            println("data : \(json)")
            
            if self.data.count == 5 {
                completion!()
                return
            }
            else {
                self.fetchData(nil)
            }
            
        })

    }
    
    func reloadCard() -> [ModelCard]? {

        data.removeAll(keepCapacity: false)

        self.fetchData { () -> () in
        }
        
        return nil
        
//        var m1 = Model()
//        m1.image = UIImage(named: "img1")
//        m1.content = "salut test"
//
//        var m2 = Model()
//        m2.image = UIImage(named: "img2")
//        m2.content = "salut test"
//        
//        return ([m1, m2])
    }
    
    override func viewDidAppear(animated: Bool) {
        let controller = RRVoteViewController()
        
        controller.delegate = self
        self.presentViewController(controller, animated: true, completion: nil)        
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

