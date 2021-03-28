//
//  ViewController.swift
//  Map
//
//  Created by 임태빈 on 2021/03/28.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet var lblLoactionInfo1: UILabel!
    @IBOutlet var lblLoactionInfo2: UILabel!
    @IBOutlet var myMap: MKMapView!
    
    // 위치 관련 매니저
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //위도 경도 설정
        lblLoactionInfo1.text = ""
        lblLoactionInfo2.text = ""
        
        //채택
        locationManager.delegate = self
        // 정확도를 최고로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 데이터를 추적하기 위해 사용자에게 승인 요구
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트를 시작
        locationManager.startUpdatingLocation()
        // map에 출력
        myMap.showsUserLocation = true
        // Do any additional setup after loading the view.
    }
    
    
    
    func goLocation(lat:CLLocationDegrees,lot: CLLocationDegrees, delta span :Double)-> CLLocationCoordinate2D {
        
        
//
//        -CLLocationCoordinate2DMake(위도, 경도)
//           CoreLocation에 속한 함수입니다.
//            myLocation의 위도, 경도 값을 파라미터로 받아 데이터 포맷을 맞춰줍니다.
//
//         -MKCoordinateSpanMake(위도 범위 값, 경도 범위 값)
//           MapKit에 속한 함수입니다.
//           myLocation의 delta(범위) 값을 파라미터로 받아 영역(span)을 만들어 주는 역할을 합니다.
//
//        -MKCoordinateRegionMake(중심 값, 영역 값)
//          MapKit에 속한 함수입니다.
//          위경도와 영역 값을 파라미터로 받아 지역값을 생성합니다.
//
//        -setRegion(지역값, _)
//          지도에 지역을 설정하여 사용자의 위치가 표시되도록 해줍니다.
        
        let pLocation = CLLocationCoordinate2DMake(lat, lot)
        
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    
    
    
    
    @IBAction func printLocation(_ sender: UISegmentedControl) {
    }
    
    


}

