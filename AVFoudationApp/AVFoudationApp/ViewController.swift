//
//  ViewController.swift
//  AVFoudationApp
//
//  Created by 임태빈 on 2021/03/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var captureSession = AVCaptureSession()

    private lazy var captureDevice = AVCaptureDevice.default(for: .video)
    private var session: AVCaptureSession?
    private var output = AVCapturePhotoOutput()
    override func viewDidLoad() {
        settingCamera()
        
    }
    func settingCamera() {
        guard let captureDevice = captureDevice else {return}
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session = AVCaptureSession()
            session?.sessionPreset = .photo
            session?.addInput(input)
            session?.addOutput(output)
            
        } catch {
            print(error)
        }
        guard let session = session else {return}
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        session.startRunning()
        
    }

}

