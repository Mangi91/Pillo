//
//  AnsweringViewController.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/5/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import UIKit
import AVFoundation

class AnsweringViewController: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var camerViewContainer: UIView!
    @IBOutlet weak var cameraFlipImageView: UIImageView!
    @IBOutlet weak var timerContainerView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var callingLabel: UILabel!
    @IBOutlet weak var cameraViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var callingLabelTopConstraint: NSLayoutConstraint!
    
    public var callingName:String!
    
    //camera properties
    private var session: AVCaptureSession?
    private var input: AVCaptureDeviceInput?
    private var currentPreviewLayer: AVCaptureVideoPreviewLayer?
    private var currentCamera = AVCaptureDevice.Position.front
    
    //timer animation properties
    private var totalSeconds:Float = 1
    private let animationDuration: Double = 1.0
    private var animationStarteDate = Date()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callingLabel.text = callingName
        
        //setting up constraints for non iPhone-X phones
        let device = UIDevice.current.name
        cameraViewTopConstraint.priority = device != "iPhone X" ? UILayoutPriority(1000) : UILayoutPriority(998)
        callingLabelTopConstraint.priority = device != "iPhone X" ? UILayoutPriority(1000) : UILayoutPriority(998)
        
        //rounded corners
        cameraView.layer.cornerRadius = 5
        cameraView.clipsToBounds = true
        timerContainerView.layer.cornerRadius = 5
        timerContainerView.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AnsweringViewController.flipCameraView))
        cameraFlipImageView.addGestureRecognizer(tapGesture)
        
        if !Platform.isSimulator {
            setupCameraView(withPosition: currentCamera)
        }
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateTimer))
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !Platform.isSimulator {
            session?.startRunning()
        }
    }
    
    @IBAction func hangupButtonTapped(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @objc private func updateTimer() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStarteDate)
        
        if elapsedTime > animationDuration {
            let minutes = Int(floor(totalSeconds / 60))
            let remainingSeconds = Int(totalSeconds) - minutes * 60;
            
            let minutesString = "\(minutes)".count > 1 ? "\(minutes)" : "0\(minutes)"
            let remainingSeconsString = "\(remainingSeconds)".count > 1 ? "\(remainingSeconds)" : "0\(remainingSeconds)"
            
            timerLabel.text = "\(minutesString):\(remainingSeconsString)"
            
            totalSeconds += 1
            animationStarteDate = Date()
        }
    }
    
    @objc private func flipCameraView() {
        if !Platform.isSimulator {
            session?.beginConfiguration()
            
            currentCamera = currentCamera == .front ? .back : .front
            let device = getDevice(position: currentCamera)
            
            for input in (session?.inputs)! {
                session?.removeInput(input as! AVCaptureDeviceInput)
            }
            
            let input: AVCaptureDeviceInput
            
            do {
                input  = try AVCaptureDeviceInput(device: device!)
            } catch {
                return
            }
            
            if (session?.canAddInput(input))! {
                session?.addInput(input)
            }
            
            self.session?.commitConfiguration()
            
            UIView.transition(with:camerViewContainer, duration: 0.5, options: .transitionFlipFromRight, animations:{
                self.camerViewContainer.backgroundColor = UIColor.clear
            }, completion:nil)
        }
    }
    
    private func setupCameraView(withPosition position: AVCaptureDevice.Position) {
        session = AVCaptureSession()
        session?.sessionPreset = AVCaptureSession.Preset.photo
        
        let camera = getDevice(position: position)
        
        do {
            input = try AVCaptureDeviceInput(device: camera!)

            if let session = session {
                if(session.canAddInput(input!)) {
                    session.addInput(input!)
                }
            }
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session!)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer.connection!.videoOrientation = AVCaptureVideoOrientation.portrait
            
            //previewLayer will have the same size and position of the cameraView
            previewLayer.frame = cameraView.bounds
            
            cameraView.layer.insertSublayer(previewLayer, at: 0)
            //session?.startRunning()
        } catch {
            input = nil
        }
    }
    
    //Get the device (Front or Back)
    private func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
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
