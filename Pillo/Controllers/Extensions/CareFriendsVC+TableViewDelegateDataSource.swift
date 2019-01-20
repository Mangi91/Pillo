//
//  CareFriendsVC+TableViewDelegateDataSource.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/20/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import UIKit

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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
