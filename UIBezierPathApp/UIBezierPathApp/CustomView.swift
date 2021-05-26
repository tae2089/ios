//
//  CustomView.swift
//  UIBezierPathApp
//
//  Created by 임태빈 on 2021/03/29.
//

import UIKit

class CustomView: UIView {
    
    func createCustomPath(padding: CGFloat, startY: CGFloat, endY: CGFloat) -> UIBezierPath {
          let path = UIBezierPath()
          path.move(to: CGPoint(x: bounds.minX + padding, y: bounds.minY + startY))
          path.addLine(to: CGPoint(x: bounds.minX + padding, y: bounds.maxY - padding))
          path.addLine(to: CGPoint(x: bounds.maxX - padding, y: bounds.maxY - padding))
          path.addLine(to: CGPoint(x: bounds.maxX - padding, y: bounds.minY + endY))
          path.close()
        path.stroke()
          return path
      }
    
}
