//
//  CheckBoxButton.swift
//  GalleryApp
//
//  Created by 임태빈 on 2021/04/03.
//

import UIKit
import Then
import M13Checkbox
class CheckBoxButton: UIButton {
    
    var checkbox:M13Checkbox!
    
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        

        
        checkbox = M13Checkbox().then {
        $0.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        $0.stateChangeAnimation = .bounce(.fill)
        $0.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        }
    }

    @objc
    func changeState() -> Void {
        self.checkbox.setCheckState(.checked, animated: true)
        print("test")
    }
    

}
