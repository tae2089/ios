//
//  ViewController.swift
//  MyAlbum
//
//  Created by 임태빈 on 2020/11/14.
//

import UIKit

class ViewController: UIViewController {

    //instance variable은 전범위에서 사용된다.
    var current = 0
    
    //변수와 상수
    //var는 variable -> 값을 바꿀 수 있음
    //let은 constant -> 값을 바꿀 수 없음
    
    //아웃렛 연결하기
    @IBOutlet weak var changeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeValue()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func hello(_ sender: Any) {
        //String variable
        let message = "가격은 ₩\(current) 입니다."
        
        let alert = UIAlertController(title: "hello", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in self.changeValue() })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        //ok버튼 이후 changeValue 하기
        //method안에 쓰이는 variable은 local이다.
    
    }
    
   //func 함수명
    func changeValue(){
        let randomPrice = arc4random_uniform(10000)+1
        current = Int(randomPrice)
        changeLabel.text="₩ \(current)"
    }
    
    //closure
    
    //image -> 1x,2x,3x use
    //
    
    
    
    
    
    
    
}

