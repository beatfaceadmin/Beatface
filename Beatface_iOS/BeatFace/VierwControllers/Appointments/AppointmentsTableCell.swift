//
//  AppointmentsTableCell.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 11/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class AppointmentsTableCell: UITableViewCell {

   
   // Outlets for table in MyBfAppointmentsVc (Customer)
    @IBOutlet weak var bNameLbl: UILabel!
    @IBOutlet weak var bAddressLbl: UILabel!
    @IBOutlet weak var bArtistImg: UIImageView!
   @IBOutlet weak var bCell2View: UIView!
  @IBOutlet weak var mArtistName: UILabel!
  @IBOutlet weak var mTimeLbl: UILabel!
  
   
    // Outlets for table in YourBfAppointmentsVc (Artist)
    @IBOutlet weak var bNameLabel2: UILabel!
    @IBOutlet weak var bAddressLbl2: UILabel!
    @IBOutlet weak var bArtistImg2: UIImageView!
 
    let obj = GenFuncs()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bArtistImg?.layer.cornerRadius = (self.bArtistImg?.frame.height)! / 2
        self.bArtistImg2?.layer.cornerRadius = (self.bArtistImg2?.frame.height)! / 2
        self.bCell2View?.layer.cornerRadius = 10
      
        
       
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
