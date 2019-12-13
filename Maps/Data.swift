//
//  Data.swift
//  iOSProject
//
//  Created by  Nikita Paralkar on 2019-11-26.
//  Copyright © 2019 Matthew Marini. All rights reserved.
//

import UIKit

class Data: NSObject {
    

    var id : Int?
    var loc : String?
    
    func initWithData(theRow i : Int, theLoc l : String){
        id = i
        loc = l
    }
}
