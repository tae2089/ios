//
//  TestView.swift
//  UIBezierPathApp
//
//  Created by 임태빈 on 2021/03/29.
//

import UIKit

class TestView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 30, y: 100))
        path.close()
        path.stroke()
    }

    
    func test(){
        print("hello")
    }
}
