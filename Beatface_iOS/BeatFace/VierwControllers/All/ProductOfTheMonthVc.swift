//
//  ProductOfTheMonthVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 25/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class ProductOfTheMonthVc: UIViewController {

    @IBOutlet weak var bView1: UIView!
    @IBOutlet weak var bView2: UIView!
    @IBOutlet weak var bView3: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    let imgTitle = UIImage(named: "titleProductOfTheMonth")
        navigationItem.titleView = UIImageView(image: imgTitle)
        self.bView1.layer.borderWidth = 0.4
        self.bView2.layer.borderWidth = 0.4
        self.bView3.layer.borderWidth = 0.4
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}
