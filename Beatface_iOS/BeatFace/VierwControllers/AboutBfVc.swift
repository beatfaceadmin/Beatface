//
//  AboutBfVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 25/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class AboutBfVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imgTitle = UIImage(named: "titleAbout")
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
