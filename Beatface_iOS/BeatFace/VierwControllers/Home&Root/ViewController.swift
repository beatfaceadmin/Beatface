//
//  ViewController.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 08/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var GetStartedBtnOut: UIButton!

    override func viewDidLoad(){
        GetStartedBtnOut?.layer.cornerRadius = (GetStartedBtnOut?.frame.height)! / 2
        super.viewDidLoad()
      let status = Constants.kUserDefaults.string(forKey: UserAttributes.status.rawValue)
      if status == "active"{
        self.navigateToHome()
      }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func navigateToHome()  {
    let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeId") as! HomeVc
    self.navigationController?.pushViewController(destinationVC, animated: true)
  }
    
    //MARK: -- Get Started Button to Sign
    @IBAction func bGetStartedBtn(_ sender: UIButton){
        performSegue(withIdentifier: "SignInScreen", sender: nil)
    }


    
    
}

