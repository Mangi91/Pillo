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
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        //make circle
        self.friendImageView.layer.borderWidth = 1
        self.friendImageView.layer.masksToBounds = false
        self.friendImageView.layer.borderColor = UIColor.clear.cgColor
        self.friendImageView.layer.cornerRadius = self.friendImageView.frame.height/2
        self.friendImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
