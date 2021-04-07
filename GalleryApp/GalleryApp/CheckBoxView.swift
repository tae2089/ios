//
//  CheckBoxView.swift
//  GalleryApp
//
//  Created by 임태빈 on 2021/04/04.
//

import UIKit
import CheckMarkView
import Then
class CheckBoxView: UIView {

    let checkMarkView = CheckMarkView().then {
        $0.style = .grayedOut
        $0.checked = true
        $0.setNeedsDisplay()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.frame.size = CGSize(width: bounds.width, height: bounds.width)
        self.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.backgroundColor = .none
        self.layer.cornerRadius = self.layer.frame.size.width/2
        
        self.addSubview(checkMarkView)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
