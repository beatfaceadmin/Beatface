//
//  SettingsVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 25/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class SettingsVc: UIViewController {

    @IBOutlet weak var bDoneBtn: UIButton!
    
    @IBAction func bBackNavBtn(_ sender: UIBarButtonItem) {
        let vchome = storyboard?.instantiateViewController(withIdentifier: "HomeId") as! HomeVc
        navigationController?.pushViewController(vchome, animated: true)
    }
    let obj = GenFuncs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obj.roundtheButton(buttonname: bDoneBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func bDoneTapped(_ sender: UIButton) {
       Constants.kUserDefaults.set(nil, forKey: appConstants.profile)
       Constants.kUserDefaults.set(nil, forKey: appConstants.token)
        Constants.kUserDefaults.set(nil, forKey: appConstants.id)
      Constants.kUserDefaults.set("logout", forKey: UserAttributes.status.rawValue)
        self.navigationController?.popToRootViewController(animated: true)
    }
    


}



