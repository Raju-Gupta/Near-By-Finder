//
//  ResultCell.swift
//  NearByFinder
//
//  Created by Raju Gupta on 10/04/20.
//  Copyright © 2020 Raju Gupta. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var viewContainer: CustomView!
    @IBOutlet weak var imgResult: UIImageView!
    @IBOutlet weak var lblTitleResult: UILabel!
    @IBOutlet weak var lblSubTitleResult: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
