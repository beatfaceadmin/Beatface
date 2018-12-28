//
//  BfSpotlightVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 25/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class BfSpotlightVc: UIViewController {

    

   
    var bNewArtistImages = ["1portrait", "2portrait", "3portrait"]
    var bNewArtistsNames = ["Jasmine Daddario", "Cristiana Brick" ,"Rubi M Andricks"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let imgTitle = UIImage(named: "titleInBfSpotlight")
        navigationItem.titleView = UIImageView(image: imgTitle)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
   
}
