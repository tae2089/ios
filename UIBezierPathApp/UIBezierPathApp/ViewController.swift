//
//  ViewController.swift
//  UIBezierPathApp
//
//  Created by 임태빈 on 2021/03/29.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {

        var tapGestureRecognizer: UITapGestureRecognizer!
        lazy var box = UIView()
        var firstPoint: CGPoint?
        var secondPoint: CGPoint?
    
        lazy var mapArea = ColorView()
    

       override func viewDidLoad() {
            super.viewDidLoad()
        
            // Do any additional setup after loading the view.
            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showMoreActions(touch:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            view.addGestureRecognizer(tapGestureRecognizer)
        
        //self.view.backgroundColor = UIColor.clear
            self.view.addSubview(mapArea)
            self.view.addSubview(box)
        
                box.backgroundColor = .green
                box.snp.makeConstraints { (make) -> Void in
                    make.width.height.equalTo(50)
                    make.center.equalTo(self.view)
               }
        
       }
    
       @objc func showMoreActions(touch: UITapGestureRecognizer) {
           let touchPoint = touch.location(in: self.view)
           
           guard let _ = firstPoint else {
                createCircle(loc: touch)
                firstPoint = touchPoint
                return
           }
           
           guard let _  = secondPoint else {
                createCircle(loc: touch)
                secondPoint = touchPoint
                addLine(fromPoint: firstPoint!, toPoint: secondPoint!)
               
                firstPoint = nil
                secondPoint = nil
               
                return
           }
       }
       
       func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
           let line = CAShapeLayer()
           let linePath = UIBezierPath()
           linePath.move(to: start)
           linePath.addLine(to: end)
           line.path = linePath.cgPath
           line.strokeColor = UIColor.orange.cgColor
           line.lineWidth = 3
           line.lineJoin = CAShapeLayerLineJoin.round
           self.view.layer.addSublayer(line)
       }


       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
   //지우기 버튼
   @IBAction func clearBtn(_ sender: Any) {
           self.mapArea.layer.sublayers = nil
       }
       
    
    func createCircle(loc: UITapGestureRecognizer){
        let touchPoint = loc.location(in: self.view)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: touchPoint.x, y: touchPoint.y), radius: CGFloat(1), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            //CGPoint(x,y)의 위치가 원의 중심입니다.
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            //change the fill color
            shapeLayer.fillColor = UIColor.clear.cgColor
            //you can change the stroke color
            shapeLayer.strokeColor = UIColor.red.cgColor
            //you can change the line width
            shapeLayer.lineWidth = 3.0
            view.layer.addSublayer(shapeLayer)
    }
    
}

