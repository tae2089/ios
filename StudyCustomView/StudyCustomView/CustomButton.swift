//
//  CustomButton.swift
//  StudyCustomView
//
//  Created by 임태빈 on 2021/04/01.
//

import UIKit

class CustomButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.frame = CGRect(x: 180, y: 180, width: bounds.width, height: bounds.width)
        self.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = self.layer.frame.size.width/2
        self.backgroundColor = UIColor(red: 255/255, green: 132/255, blue: 102/255, alpha: 1)
        self.tintColor = .red
        self.setTitle("test", for: .normal)
    }

}
