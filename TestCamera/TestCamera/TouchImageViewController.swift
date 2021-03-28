//
//  TouchImageViewController.swift
//  TestCamera
//
//  Created by 임태빈 on 2021/03/25.
//

import UIKit

class TouchImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleFront(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.recognized
        {
            let location = gestureRecognizer.location(in: gestureRecognizer.view)
            print(gestureRecognizer.location(in: gestureRecognizer.view))
            
            let testView = UIView(frame: CGRect(x: location.x, y: location.y, width:  50, height: 50))
            testView.backgroundColor = UIColor.red
            self.view.addSubview(testView)
//            view.reloadInputViews()
        }
    }
}
