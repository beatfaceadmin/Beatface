//
//  ArtistOnboarding2.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 08/03/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class ArtistOnboarding2: UIViewController{
  
@IBOutlet weak var bNextBtnOut: UIButton!


@IBOutlet weak var mCertificateTxtfld: UITextField!
@IBOutlet weak var mReasonToWorkTxtFld: UITextField!
@IBOutlet weak var mChooseTxtFld: UITextField!
@IBOutlet weak var mTravelTextField: UITextField!
  @IBOutlet weak var mToolsTextField: UITextField!
  @IBOutlet weak var mOccupationTxtFld: UITextField!
var validator:Validators!
var obj = GenFuncs()
  var artist: Artist?

override func viewDidLoad() {
  super.viewDidLoad()
   validator = Validators()
  obj.roundtheButton(buttonname: bNextBtnOut)
  let imgTitle = UIImage(named: "titleBeABfArtist")
  navigationItem.titleView = UIImageView(image: imgTitle)
  
}

override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  self.view.endEditing(true)
}



func createPopUpForSelection(title:String,ValueArray:[String],view:UIView, callback:@escaping (_ selectedValue: String?,_ selectedIndex:Int? ) -> Void)  {
  StringPickerPopover(title:title, choices: ValueArray)
    .setSelectedRow(0)
    .setDoneButton(action: { (popover, selectedRow, selectedString) in
      print("done row \(selectedRow) \(selectedString)")
      callback(selectedString,selectedRow)
    })
    .setCancelButton(action: { (_, _, _) in print("cancel")}
    )
    .appear(originView: view, baseViewController: self)
  
}


@IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
  self.navigationController?.popViewController(animated: true)
}

@IBAction func bNextBtn(_ sender: UIButton) {

  
  guard validator.validators(TF1: self.mChooseTxtFld,fieldName: "Info") == false
    || validator.validators(TF1: self.mToolsTextField,fieldName: "Info") == false
     || validator.validators(TF1: self.mTravelTextField,fieldName: "Info") == false
     || validator.validators(TF1: self.mOccupationTxtFld,fieldName: "Info") == false
     || validator.validators(TF1: self.mCertificateTxtfld,fieldName: "Info") == false
     || validator.validators(TF1: self.mReasonToWorkTxtFld,fieldName: "Info") == false
    else {
      collectInput()
      navigateToNext()
     
      return
  }
  
  }
  
  
  func collectInput() {
    self.artist?.selectionReason = self.mChooseTxtFld.text
    self.artist?.toolkit = self.mToolsTextField.text == "YES" ? true : false
    self.artist?.willingToTravel = self.mTravelTextField.text == "YES" ? true : false
    self.artist?.currentOccupation = self.mOccupationTxtFld.text
    self.artist?.certificate = self.mCertificateTxtfld.text == "YES" ? true : false
     self.artist?.workReason = self.mReasonToWorkTxtFld.text
    
  }
  
  func navigateToNext()  {
    let ArtistOnboarding3 = storyboard?.instantiateViewController(withIdentifier: "ArtistOnboarding3ID") as! ArtistOnboarding3
       ArtistOnboarding3.artist = self.artist
    self.navigationController?.pushViewController(ArtistOnboarding3, animated: true)
  }

  func getYesNo(textfield:UITextField) {
  self.createPopUpForSelection(title: "Select Option", ValueArray: ["Yes","No"], view: textfield, callback: { (value, index) in
    textfield.text = value
  })
    
   
}



}

extension ArtistOnboarding2: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    
    
    switch textField {
    case self.mCertificateTxtfld:
      self.getYesNo(textfield: self.mCertificateTxtfld)
      return false

    case self.mTravelTextField:
       self.getYesNo(textfield: self.mTravelTextField)
      return false

    case self.mToolsTextField:
      self.getYesNo(textfield: self.mToolsTextField)
      return false
    default:
      print("abc")
    }
    
    
    
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
    
    return true
  }
  
  
}





