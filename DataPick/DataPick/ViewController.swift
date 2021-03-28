//
//  ViewController.swift
//  DataPick
//
//  Created by 임태빈 on 2021/03/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentDate: UILabel!
    @IBOutlet var selectDate: UILabel!
    let timeSelector: Selector = #selector(ViewController.updateTime)
    
    var interval = 1.0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //현재 시간 자동으로 올려주기
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func pickDate(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        selectDate.text = "선택시간: " + formatter.string(from: sender.date)
        
    }
    @objc func updateTime(){
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        currentDate.text = "현재 시간 :" + formatter.string(from: date as Date)
    }
    
}

