//
//  AVCaptureDevice+GetDevice.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/20/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import AVFoundation

extension AVCaptureDevice {
    static func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: position)
        let devices: [AVCaptureDevice] = discoverySession.devices
        
        for device in devices {
            if(device.position == position) {
                return device
            }
        }
        
        return nil
    }
}
