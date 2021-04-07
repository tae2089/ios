//
//  ViewController.swift
//  ImageView
//
//  Created by 임태빈 on 2021/03/26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lampImage: UIImageView!
    @IBOutlet var btnResize: UIButton!
    
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //첫 로딩 시 여기서 진행
        // 이미지 Setting
        setImage()
    }
    
    private func setImage() -> Void {
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        lampImage.image = imgOn
    }

    @IBAction func swithcLamp(_ sender: UISwitch) {
        
        if sender.isOn{
            lampImage.image = imgOn
        }else{
            lampImage.image = imgOff
        }
    }
    
    
    @IBAction func closeUpImage(_ sender: UIButton) {
        let scale:CGFloat = 2.0
        var newWidth:CGFloat, newHight:CGFloat
        
        if (isZoom) {
            //true
            newWidth = lampImage.frame.width/scale
            newHight = lampImage.frame.height/scale
            btnResize.setTitle("확대", for: .normal)
        }else{
            // false
            newHight = lampImage.frame.height * scale
            newWidth = lampImage.frame.width*scale
            btnResize.setTitle("축소", for: .normal)
        }
        lampImage.frame.size = CGSize(width: newWidth, height: newHight)
        isZoom = !isZoom
    }
    
}

