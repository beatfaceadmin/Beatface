//
//  VCHelper.swift
//  AQUA
//
//  Created by Krishna on 21/03/17.
//  Copyright © 2017 MindfulSas. All rights reserved.
//

import Foundation
import UIKit

class VCHelper :NSObject{
    func addShadowAndBoderUIView(view :UIView) -> UIView {
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowRadius = 0.09
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
       return view
    }
    
    func addBoderUIView(view :UIView) -> UIView {
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }

  
  func addBoderCornerUIView(view :UIView,cornerRadius: CGFloat) -> UIView {
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.borderWidth = 1
      view.layer.cornerRadius = cornerRadius
    view.layer.masksToBounds = true
    return view
  }
    
    func addShadowAndBorderUIButton(btn:UIButton) -> UIButton{
        btn.layer.cornerRadius = 4
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.05
        btn.layer.shadowRadius = 2.0
        btn.layer.shadowOffset = CGSize (width:0.0, height:0.0)
        return btn
    }
    
    //MARK:BlurEffect For ImageView
    func blurEffectOnImageView(ImageView: UIImageView){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = ImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ImageView.addSubview(blurEffectView)
        
    }
    
    func createRoundImageView(img:UIImageView,cornerRadius: CGFloat) {
        img.layer.cornerRadius = cornerRadius
        img.layer.masksToBounds = true
    }
    
    func createRoundImageViewWithBoder(img:UIImageView,boderWidth: CGFloat,boderColor :CGColor,cornerRadius: CGFloat) {
        img.layer.cornerRadius = cornerRadius
        img.layer.borderWidth = boderWidth
        img.layer.borderColor = boderColor
        img.layer.masksToBounds = true
    }

    func createRoundButtonWithBoder(btn:UIButton,boderWidth: CGFloat,boderColor :CGColor,cornerRadius: CGFloat) {
        btn.layer.cornerRadius = cornerRadius
        btn.layer.borderWidth = boderWidth
        btn.layer.borderColor = boderColor
        btn.layer.masksToBounds = true
    }
  
  
  func roundImageView(imageView:UIImageView) {
    imageView.layer.borderWidth = 1.0
    imageView.layer.masksToBounds = false
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.cornerRadius = imageView.frame.size.width/2
    imageView.clipsToBounds = true
  }
  

    func createRoundLabelWithBoder(lbl:UILabel,boderWidth: CGFloat,boderColor :CGColor,cornerRadius: CGFloat) {
        lbl.layer.cornerRadius = cornerRadius
        lbl.layer.borderWidth = boderWidth
        lbl.layer.borderColor = boderColor
        lbl.layer.masksToBounds = true
    }
    // MARK:-- PlaceHolder for textview
    //create a placeholder UILabel in your textview class and pass in this function along with placeholder text.
    //Remember to set label hidden in textview didChange Delegate Method
    func setPlaceholderForTextView(placeholderLabel:UILabel,textView :UITextView,placeholderText:String){
        placeholderLabel.text = placeholderText
        placeholderLabel.font = UIFont.systemFont(ofSize: textView.font!.pointSize)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x:5, y:textView.font!.pointSize / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
  
      

 
    
    
}

extension DispatchQueue {
  
  static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
    DispatchQueue.global(qos: .background).async {
      background?()
      if let completion = completion {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
          completion()
        })
      }
    }
  }
  
}
