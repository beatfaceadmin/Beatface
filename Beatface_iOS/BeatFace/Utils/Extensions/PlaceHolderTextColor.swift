//
//  PlaceHolderTextColor.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 07/03/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}
