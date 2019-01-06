//
//  CareFriendTableViewCell.swift
//  Pillo
//
//  Created by Manuel Cubillo on 1/3/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import UIKit

class CareFriendTableViewCell: UITableViewCell {
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendRequestStatus: UILabel!
    @IBOutlet weak var phoneIcon: UIImageView!
    
    private var friendCenterConstraint: NSLayoutConstraint?
    public var friendCenterYPriority: Float {
        get {
            if let priority = friendCenterConstraint?.priority {
                return priority.rawValue
            } else {
                return 0
            }
        } set(newPriority) {
            if let _ = friendCenterConstraint?.priority {
                friendCenterConstraint!.priority = UILayoutPriority(rawValue: newPriority)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //make circle
        self.friendImageView.layer.borderWidth = 1
        self.friendImageView.layer.masksToBounds = false
        self.friendImageView.layer.borderColor = UIColor.clear.cgColor
        self.friendImageView.layer.cornerRadius = self.friendImageView.frame.height/2
        self.friendImageView.clipsToBounds = true
        
        friendCenterConstraint = findConstraint("friendNameCenterY")
    }
    
    private func findConstraint(_ constraint: String) -> NSLayoutConstraint? {
        for c in self.contentView.constraints {
            if let id = c.identifier {
                if id == constraint {
                    return c
                }
            }
        }
        
        return nil
    }
}
