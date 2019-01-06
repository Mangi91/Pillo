//
//  CallingViewController.swift
//  Pillo
//
//  Created by Manuel Cubillo on 12/30/18.
//  Copyright © 2018 Manuel Cubillo. All rights reserved.
//

import UIKit
import Lottie

class CallingViewController: UIViewController {
    @IBOutlet weak var animationViewContainer: UIView!
    @IBOutlet weak var friendNameLabel: UILabel!
    
    public var friendImageName: String!
    public var friendName: String!
    
    private var animationView:LOTAnimationView?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnimationView()
        setupFriend(withFriendName:friendName, andFriendImage: UIImage(named:friendImageName)!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createGradientBackground()
        animationView?.play()
    }
    
    @IBAction func hangUp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupAnimationView() {
        animationView = LOTAnimationView(name:"RippleAnimation")
        animationView?.loopAnimation = true
        animationViewContainer.addSubview(animationView!)
        
        //add constraints
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item:animationView as Any, attribute: .top, relatedBy: .equal, toItem: animationViewContainer, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item:animationViewContainer, attribute: .trailing, relatedBy: .equal, toItem: animationView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item:animationViewContainer, attribute: .bottom, relatedBy: .equal, toItem: animationView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item:animationView as Any, attribute: .leading, relatedBy: .equal, toItem: animationViewContainer, attribute: .leading, multiplier: 1.0, constant: 0)
        ])
    }
    
    private func createGradientBackground() {
        //blues
        let color1 = UIColor(red:77/255, green:130/255, blue:230/255, alpha:1.0).cgColor
        let color2 = UIColor(red:71/255, green:123/255, blue:225/255, alpha:1.0).cgColor
        let color3 = UIColor(red:67/255, green:119/255, blue:220/255, alpha:1.0).cgColor
        let color4 = UIColor(red:63/255, green:115/255, blue:216/255, alpha:1.0).cgColor
        let color5 = UIColor(red:52/255, green:103/255, blue:203/255, alpha:1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [color1,color2,color3,color4,color5]
        gradientLayer.locations = [0.0, 0.20, 0.40, 0.6, 1.0]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
}


