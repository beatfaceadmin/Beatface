//
//  PaymentDetailsVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 08/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class PaymentDetailsVc: UIViewController {

    @IBOutlet weak var bProceedBtnOut: UIButton!
    @IBOutlet weak var bServiceView: UIView!
    @IBOutlet weak var bPaymentDetailsView: UIView!
    @IBOutlet weak var bPaymentsModeView: UIView!
    @IBOutlet weak var bCardDetailsView: UIView!
    
    
    let obj = GenFuncs()
    override func viewDidLoad() {
        super.viewDidLoad()
        obj.roundtheButton(buttonname: bProceedBtnOut)
        obj.addShadowToView(viewname: bServiceView)
        obj.addShadowToView(viewname: bPaymentDetailsView)
        obj.addShadowToView(viewname: bPaymentsModeView)
        obj.addShadowToView(viewname: bCardDetailsView)
}

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
   

    
    
}
