//
//  GeneralUseFuncs.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 15/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation
import UIKit

class GenFuncs{
    func roundTheView(viewname:UIView!)
    {
        return (viewname?.layer.cornerRadius = (viewname?.frame.height)! / 2)!
        
    }
    
    func roundtheButton(buttonname:UIButton!)
    {
        return (buttonname?.layer.cornerRadius = (buttonname?.frame.height)! / 2)!
    }
    
    func roundViewByHalf (viewname:UIView!){
        return (viewname?.layer.cornerRadius = 10)!
    }

    func addShadowToView(viewname:UIView!)
    {
        viewname.layer.shadowColor = UIColor.lightGray.cgColor
        viewname.layer.shadowOpacity = 1.0
        viewname.layer.shadowOffset = CGSize.zero
        viewname.layer.shadowRadius = 4
    }
    
    func setBorderWidth (textfieldname:UITextField) {
     textfieldname.layer.borderWidth = 0.1
    }
    
}


