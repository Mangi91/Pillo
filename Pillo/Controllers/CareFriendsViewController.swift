//
//  CareFriendsViewController.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/3/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import UIKit

class CareFriendsViewController: UIViewController {
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var carefriendsTitleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var careTeamLabelTopConstraint: NSLayoutConstraint!
    
    public var friends = [
        (imageName:"alicia",friendName:"Alicia Cory", isFriend: true),
        (imageName:"bry",friendName:"Bryan Hanson", isFriend: true),
        (imageName:"celina",friendName:"Celina Thompson", isFriend: false),
        (imageName:"flor",friendName:"Flor Roberts", isFriend: true),
        (imageName:"frances",friendName:"Frances Gonzales", isFriend: true),
        (imageName:"isa",friendName:"Isabel Ramirez", isFriend: false),
        (imageName:"john",friendName:"John Rhodes", isFriend: true),
        (imageName:"lucy",friendName:"Lucy Potter", isFriend: true),
        (imageName:"ross",friendName:"Ross Barrymore", isFriend: true),
        (imageName:"joanne", friendName:"Joanne Wade", isFriend: false),
        (imageName:"hazel", friendName:"Hazel Mendoza", isFriend: true),
        (imageName:"jackie", friendName:"Jackie Holt", isFriend: false)
    ]
    
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carefriendsTitleLabelTopConstraint.iPhoneXPriority(maxPriority: 1000, minPriority: 998)
        careTeamLabelTopConstraint.iPhoneXPriority(maxPriority: 1000, minPriority: 998)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        friendsTableView.roundedCorners(radius: 5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "callFriend" {
            let friend = sender as! (imageName:String,friendName:String)
            let vc = segue.destination as! CallingViewController
            vc.friendName = friend.friendName
            vc.friendImageName = friend.imageName
        }
    }
}

