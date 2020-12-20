//
//  BountyInfo.swift
//  BountyList
//
//  Created by 임태빈 on 2020/12/20.
//

import UIKit

struct BountyInfo {
    let name : String
    let bounty : Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty : Int) {
        self.name = name
        self.bounty = bounty
    }
}
