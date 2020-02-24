//
//  CallingViewController.swift
//  Pillo
//
//  Created by Manuel Cubillo on 12/30/18.
//  Copyright © 2018 Manuel Cubillo. All rights reserved.
//

import UIKit
import Lottie
import AVFoundation

class CallingViewController: UIViewController {
    @IBOutlet weak var animationViewContainer: UIView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendNameLabelTop: NSLayoutConstraint!
    @IBOutlet weak var hangupButton: UIButton!
    
    public var friendImageName: String!
    public var friendName: String!
    
    private var animationView:LOTAnimationView?
    private var segueToAnswerVC = true
    private var playSound = true
    private var soundEffect: AVAudioPlayer?
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendNameLabelTop.iPhoneXPriority(maxPriority: 1000, minPriority: 998)
        setupAnimationView()
        setupFriend(withFriendName:friendName, andFriendImage: UIImage(named:friendImageName)!)
        soundEffect = AVAudioPlayer(withResource:"tone-beep.wav", numberOfLoops:3)
        
        friendNameLabel.accessibilityIdentifier = "friendName"
        hangupButton.accessibilityIdentifier = "callingHangupButton"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addGradientLayer(colors: [
            UIColor.PilloRoyalBlue1.cgColor,
            UIColor.PilloRoyalBlue2.cgColor,
            UIColor.PilloRoyalBlue3.cgColor,
            UIColor.PilloRoyalBlue4.cgColor,
            UIColor.PilloMariner.cgColor
        ], locations:[0.0, 0.20, 0.40, 0.6, 1.0])
        
        animationView?.play()
        soundEffect?.play(withDelay: 0.0, completion: {
            self.continueSoundEffect(withDelay:3.0)
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if self.segueToAnswerVC {
                self.playSound = false
                self.animationView?.pause()
                self.performSegue(withIdentifier:"answerFriend", sender: self.friendName)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "answerFriend" {
            let vc = segue.destination as! AnsweringViewController
            vc.callingName = friendName
        }
    }
    
    @IBAction func hangUp(_ sender: UIButton) {
        segueToAnswerVC = false
        playSound = false
        animationView?.pause()
        dismiss(animated: false, completion: nil)
    }
    
    private func setupAnimationView() {
        animationView = LOTAnimationView(name:"RippleAnimation")
        animationView?.loopAnimation = true
        animationViewContainer.addSubview(animationView!)
        
        //add constraints
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item:animationView as Any, attribute: .top, relatedBy: .equal, toItem: animationViewContainer, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item:animationViewContainer as Any, attribute: .trailing, relatedBy: .equal, toItem: animationView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item:animationViewContainer as Any, attribute: .bottom, relatedBy: .equal, toItem: animationView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item:animationView as Any, attribute: .leading, relatedBy: .equal, toItem: animationViewContainer, attribute: .leading, multiplier: 1.0, constant: 0)
        ])
    }
    
    private func setupFriend(withFriendName: String, andFriendImage image: UIImage) {
        friendNameLabel.text = friendName
        
        //setup friend imageview
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x:-95, y:-95, width: 190, height: 190)
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        animationView?.addSubview(imageView, toKeypathLayer:LOTKeypath(string:"Photo"))
    }
        
    private func continueSoundEffect(withDelay delay: Double) {
        if playSound {
            soundEffect?.play(withDelay:delay, completion: {
                self.continueSoundEffect(withDelay:delay)
            })
        } else {
            self.soundEffect?.pause()
        }
    }
}
