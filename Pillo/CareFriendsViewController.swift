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
    var friends = [
        (imageName:"alicia",friendName:"Alicia Cory"),
        (imageName:"bry",friendName:"Bryan Hanson"),
        (imageName:"celina",friendName:"Celina Thompson"),
        (imageName:"flor",friendName:"Flor Roberts"),
        (imageName:"frances",friendName:"Frances Gonzales"),
        (imageName:"isa",friendName:"Isabel Ramirez"),
        (imageName:"john",friendName:"John Rhodes"),
        (imageName:"lucy",friendName:"Lucy Potter"),
        (imageName:"ross",friendName:"Ross Barrymore")
    ]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //rounded corners
        friendsTableView.layer.cornerRadius = 5
        friendsTableView.clipsToBounds = true
        
        //shadow
//        friendsTableView.layer.shadowPath = UIBezierPath(roundedRect: friendsTableView.bounds, cornerRadius: friendsTableView.layer.cornerRadius).cgPath
//        friendsTableView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
//        friendsTableView.layer.shadowOpacity = 0.5
//        friendsTableView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        friendsTableView.layer.shadowRadius = 1
//        friendsTableView.layer.masksToBounds = true
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
