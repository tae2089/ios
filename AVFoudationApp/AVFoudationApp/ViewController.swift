//
//  ViewController.swift
//  AVFoudationApp
//
//  Created by 임태빈 on 2021/03/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCapturePhotoCaptureDelegate{

    var captureSession : AVCaptureSession!
    
    var backCamera : AVCaptureDevice!
    var frontCamera : AVCaptureDevice!
    var backInput : AVCaptureInput!
    var frontInput : AVCaptureInput!
    
    var previewLayer : AVCaptureVideoPreviewLayer!
    
    var videoOutput : AVCaptureVideoDataOutput!
    
    var takePicture = false
    var backCameraOn = true
    
    //MARK: - open Camera
    func openCamera(){}
    
    //MARK: - capture Camera
    
    //MARK: - swith Caemera
    
    //MARK: - measure Distance
    
    //MARK: - goto another Page
    

}


    

