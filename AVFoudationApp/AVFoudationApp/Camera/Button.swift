//
//  Button.swift
//  AVFoudationApp
//
//  Created by 임태빈 on 2021/03/30.
//

import Foundation
import AVFoundation
import CoreVideo
import MobileCoreServices
import Accelerate
import Photos

class Button{
    enum CameraType {
        case back(Bool)
        case front(Bool)
    }
    func captureDevice(cameraType: CameraType) -> AVCaptureDevice {
        let devices: [AVCaptureDevice]
        switch cameraType {
        case .front(let _):
            var deviceTypes: [AVCaptureDevice.DeviceType] = [.builtInTrueDepthCamera]
            //if !requireDepth {
                deviceTypes.append(.builtInWideAngleCamera)
            //}
            devices = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: .video, position: .front).devices
        case .back(let _):
            var deviceTypes: [AVCaptureDevice.DeviceType] = [.builtInDualCamera]
            //if !requireDepth {
                deviceTypes.append(contentsOf: [.builtInWideAngleCamera, .builtInTelephotoCamera])
            //}
            devices = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: .video, position: .back).devices
        }
        guard let device = devices.first else {
            return AVCaptureDevice.default(for: .video)!
        }
        return device
    }
    }
