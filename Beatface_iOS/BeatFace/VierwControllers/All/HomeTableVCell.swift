//
//  HomeTableVCell.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 10/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class HomeTableVCell: UITableViewCell {

    @IBOutlet weak var gHomeCellImg: UIImageView! //For customers
    
    
    @IBOutlet weak var gHome2CellImg: UIImageView! // For Artists
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
