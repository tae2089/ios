//
//  ViewController.swift
//  pickPicture
//
//  Created by 임태빈 on 2021/03/27.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{

    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_COLUMN = 1
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    
    @IBOutlet var ItemLabel: UILabel!
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var ImageView: UIImageView!
    //실제 이미지
    var imageArray = [UIImage?]()
    //이미지 이름
    var imageFilename = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerImage.dataSource = self
        pickerImage.delegate = self
        for i in 0 ..< 5{
            let image = UIImage(named: imageFilename[i])
            imageArray.append(image)
            
        }
        ItemLabel.text = imageFilename[0]
        ImageView.image = imageArray[0]
    }

    
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }

    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFilename.count
    }
    

    // 이미지 넣어주기
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image:imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 500, height: 250)
        
        return imageView
    }

    // 선택할 경우 해당 이미지로 변경
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ItemLabel.text = imageFilename[row]
        ImageView.image = imageArray[row]
    }

}

