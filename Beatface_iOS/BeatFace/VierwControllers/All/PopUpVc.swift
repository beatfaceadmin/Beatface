//
//  PopUpVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 06/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class PopUpVc: UIViewController {

    @IBOutlet weak var bDismissBtnOutl: UIButton!
    
    @IBOutlet weak var bPopUpView: UIView!
    let obj = GenFuncs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obj.roundtheButton(buttonname: bDismissBtnOutl)
        bPopUpView.layer.cornerRadius = 10
        bPopUpView.layer.masksToBounds = true

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    @IBAction func bDismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }

}
