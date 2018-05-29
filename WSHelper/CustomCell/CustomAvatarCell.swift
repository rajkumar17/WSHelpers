//
//  CustomAvatarCell.swift
//  WSHelper
//
//  Created by Sogo Computers on 5/16/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import UIKit

class CustomAvatarCell: UITableViewCell {

    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
