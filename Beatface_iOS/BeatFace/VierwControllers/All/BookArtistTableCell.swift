//
//  BookArtistTableCell.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 15/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class BookArtistTableCell: UITableViewCell {

  var obj: GenFuncs!
  var vcHelper: VCHelper!
    @IBOutlet weak var bArtistBookImg: UIImageView!
    
    @IBOutlet weak var bArtistNameLbl: UILabel!
    
    @IBOutlet weak var bAvailabilityLbl: UILabel!
    
    @IBOutlet weak var bBookAnArtistCellView: UIView!
    @IBOutlet weak var bArtistAddressLbl: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      obj = GenFuncs()
      vcHelper = VCHelper()
        obj.addShadowToView(viewname: bBookAnArtistCellView)
        obj.roundTheView(viewname: bBookAnArtistCellView)
      vcHelper.addBoderCornerUIView(view: bBookAnArtistCellView, cornerRadius: 5.0)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
