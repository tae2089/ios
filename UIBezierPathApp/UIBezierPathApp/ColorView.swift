//
//  ColorView.swift
//  UIBezierPathApp
//
//  Created by 임태빈 on 2021/03/31.
//
import UIKit
import Foundation
import SnapKit
class ColorView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
