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
    
    private var friends = [
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up constraints for non iPhone-X phones
        let device = UIDevice.current.name
        carefriendsTitleLabelTopConstraint.priority = device != "iPhone X" ? UILayoutPriority(1000) : UILayoutPriority(998)
        careTeamLabelTopConstraint.priority = device != "iPhone X" ? UILayoutPriority(1000) : UILayoutPriority(998)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //rounded corners
        friendsTableView.layer.cornerRadius = 5
        friendsTableView.clipsToBounds = true
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

extension CareFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"friendCell", for: indexPath) as! CareFriendTableViewCell
        cell.friendImageView.image = UIImage(named: friend.imageName)
        cell.friendName.text = friend.friendName
        cell.friendCenterYPriority = friend.isFriend ? 300 : 200
        cell.friendRequestStatus.alpha = friend.isFriend ? 0.0 : 1.0
        cell.phoneIcon.alpha = friend.isFriend ? 1.0 : 0.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row]
        
        if friend.isFriend {
            performSegue(withIdentifier:"callFriend", sender:(imageName:friend.imageName,friendName:friend.friendName))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
