//
//  ModelCard.swift
//  tindView
//
//  Created by Remi Robert on 05/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit

protocol ModelCard {
    var image: UIImage! { get set }
    var content: String! { get set }
    var desc: String! { get set }
}

class Model: NSObject, ModelCard {
    var image: UIImage!
    var content: String!
    var desc: String!
}
