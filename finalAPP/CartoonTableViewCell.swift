//
//  CartoonTableViewCell.swift
//  finalAPP
//
//  Created by User20 on 2019/6/17.
//  Copyright © 2019 ouo. All rights reserved.
//

import UIKit

class CartoonTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
