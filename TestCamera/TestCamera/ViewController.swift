//
//  ViewController.swift
//  TestCamera
//
//  Created by 임태빈 on 2021/03/25.
//

import UIKit
import ARKit


class ViewController: UIViewController {

    let myStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


    
    @IBAction func btnCameraCapture(_ sender : UIButton){
        
        
        // 페이지 이동
        movePage()
    }
    
    func movePage() {
        let page = myStoryboard.instantiateViewController(identifier: "TouchContrller")
            self.show(page,sender: self)
        
    }
}
