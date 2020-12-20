//
//  BountyViewModel.swift
//  BountyList
//
//  Created by 임태빈 on 2020/12/20.
//

import UIKit

class BountyViewModel {
    
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 30000000),
        BountyInfo(name: "nami", bounty: 80000000),
        BountyInfo(name: "robin", bounty: 77000000),
        BountyInfo(name: "sanji", bounty: 120000000),
        BountyInfo(name: "zoro", bounty: 30000000),
    ]
    
    var sortedList: [BountyInfo]{
        let sortedList = bountyInfoList.sorted{ prev,next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }

    func bounttInfo(at index:Int) -> BountyInfo {
        return sortedList[index]
    }
    
}


class DetailViewModel {
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo) {
        self.bountyInfo = model
    }
}
