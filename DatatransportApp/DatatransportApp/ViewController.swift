//
//  ViewController.swift
//  DatatransportApp
//
//  Created by 임태빈 on 2021/03/30.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    
    @IBOutlet var lBLtest: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func testGet1(_ sender: UIButton) {
        //접근하고자 하는 URL 정보
        testPost()
        
        //객체 받아오기
        //testGetPerson()
    }
    
    
    func testGet(){
        let URL = "http://tae2089.synology.me:81/test2"
        //전송할 파라미터 정보
        //위의 URL와 파라미터를 담아서 POST 방식으로 통신하며, statusCode가 200번대(정상적인 통신) 인지 유효성 검사 진행
        let alamo = AF.request(URL, method: .get).validate(statusCode: 200..<300)
        //결과값으로 문자열을 받을 때 사용
        alamo.responseString() { response in
            switch response.result
            {
            //통신성공
            case .success(let value):
                print("value: \(value)")
                self.lBLtest.text = value
                
            //통신실패
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }
        }
    }
    
    
    
    
    func testGetPerson(){
        let URL = "http://tae2089.synology.me:81/getPerson"
        //전송할 파라미터 정보
        //위의 URL와 파라미터를 담아서 POST 방식으로 통신하며, statusCode가 200번대(정상적인 통신) 인지 유효성 검사 진행
        let alamo = AF.request(URL, method: .get).validate(statusCode: 200..<300)
        //결과값으로 문자열을 받을 때 사용
        alamo.responseJSON() { response in
            switch response.result
            {
            //통신성공
            case .success(let value):
                print("value: \(value)")
                let json = JSON(value)
                self.lBLtest.text = json["name"].stringValue
                
            //통신실패
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func testPost(){
        //접근하고자 하는 URL 정보
        let URL = "http://tae2089.synology.me:81/test1"
        //전송할 파라미터 정보
        //let array: [UInt8] = Array("손홍민".utf8)
        let PARAM:Parameters = [
            "name":"손흥민",
            "age": "12"
        ]
        
        //위의 URL와 파라미터를 담아서 POST 방식으로 통신하며, statusCode가 200번대(정상적인 통신) 인지 유효성 검사 진행
        
        let alamo = AF.request(URL, method: .post, parameters: PARAM, encoding: JSONEncoding.default,headers: nil).validate(statusCode: 200..<300)
        //결과값으로 문자열을 받을 때 사용
        alamo.responseString() { response in
            switch response.result
            {
            //통신성공
            case .success(let value):
                print("value: \(value)")
                self.lBLtest.text = value
                
            //통신실패
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
            }
        }
    }
    

}

