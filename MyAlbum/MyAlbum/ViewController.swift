//
//  ViewController.swift
//  MyAlbum
//
//  Created by 임태빈 on 2020/11/14.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func hello(_ sender: Any) {
        let alert = UIAlertController(title: "hello", message: "My First App!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    @IBAction func change(_ sender: Any) {
        let alert = UIAlertController(title: "도오오전", message: "도오오오전입니다!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

