//
//  ListCell.swift
//  BountyList
//
//  Created by 임태빈 on 2020/12/20.
//

import UIKit

class GridCell: UICollectionViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
        //이미지 넣는 방법
        imgView.image = UIImage(named: "\(info.name).jpg")
        //text에 값 넣는 방법
        nameLabel.text = info.name
        //text에다가는 string만들어갈 수 있음
        bountyLabel.text = "\(info.bounty)"
    }
}
