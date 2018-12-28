//
//  UIView.swift
//  AQUA
//
//  Created by Krishna on 27/04/17.
//  Copyright © 2017 MindfulSas. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UIImage with extension
extension UIView{
    func image() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
