//
//  FeedBackVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 19/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class FeedBackVc: UIViewController {

    @IBOutlet weak var bNotNowBtnOut: UIButton!
    @IBOutlet weak var bContinueBtnOut: UIButton!
    
    let obj = GenFuncs()
    override func viewDidLoad() {
        super.viewDidLoad()
        obj.roundtheButton(buttonname: bContinueBtnOut)
        obj.roundtheButton(buttonname: bNotNowBtnOut)
        
}

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

  
}
