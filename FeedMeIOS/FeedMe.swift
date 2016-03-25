//
//  FeedMe.swift
//  FeedMeIOS
//
//  Created by Jun Chen on 19/03/2016.
//  Copyright © 2016 FeedMe. All rights reserved.
//

import UIKit

struct FeedMe {
    
    struct Path {
        static let TEXT_HOST = "http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/"
        static let PICTURE_HOST = "http://ec2-52-27-149-51.us-west-2.compute.amazonaws.com:8080/"
    }
    
    struct Variable {
        static var userID: Int?
        static var restaurantID: Int?
        static var restaurantName: String?
        static var dishID: Int?
        static var images: [String: UIImage]?
    }
    
    struct Order {
        // total number of items:
        static var itemsCount: Int = 0
        
        // total number of prices:
        static var totalPrice: Double = 0
        
        // information for all dishes in the shopping cart:
        // list of all dishes:
        static var dishes: [Dish] = [Dish]()
        // count of every dish: Dish ID -> Dish Count:
        static var dish2count: Dictionary<Int, Int> = Dictionary<Int, Int>()
    }
    
}