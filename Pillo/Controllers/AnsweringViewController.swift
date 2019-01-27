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
    @IBOutlet weak var hangupButton: UIButton!
    
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
    
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callingLabel.text = callingName
        
        cameraViewTopConstraint.iPhoneXPriority(maxPriority: 1000, minPriority: 998)
        callingLabelTopConstraint.iPhoneXPriority(maxPriority: 1000, minPriority: 998)
        
        cameraView.roundedCorners(radius:5)
        timerContainerView.roundedCorners(radius:5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AnsweringViewController.flipCameraView))
        cameraFlipImageView.addGestureRecognizer(tapGesture)
        
        if !Platform.isSimulator { setupCameraView(withPosition: currentCamera) }
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateTimer))
        displayLink.add(to: .main, forMode: .default)
        
        callingLabel.accessibilityIdentifier = "callingFriendLabel"
        hangupButton.accessibilityIdentifier = "answeringHangupButton"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !Platform.isSimulator { session?.startRunning() }
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
            let remainingSecondsString = "\(remainingSeconds)".count > 1 ? "\(remainingSeconds)" : "0\(remainingSeconds)"
            
            timerLabel.text = "\(minutesString):\(remainingSecondsString)"
            
            totalSeconds += 1
            animationStarteDate = Date()
        }
    }
    
    @objc private func flipCameraView() {
        if !Platform.isSimulator {
            session?.beginConfiguration()
            
            currentCamera = currentCamera == .front ? .back : .front
            let device = AVCaptureDevice.getDevice(position: currentCamera)
            
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
        
        let camera = AVCaptureDevice.getDevice(position: position)
        
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
        } catch {
            input = nil
        }
    }
}
