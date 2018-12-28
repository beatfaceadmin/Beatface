//
//  DetailsVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 15/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class DetailsVc: UIViewController, UITextFieldDelegate {

  
    
    
    @IBOutlet weak var gVerificationCodeView: UIView!
    @IBOutlet weak var gServiceView: UIView!
    @IBOutlet weak var gPayementVIew: UIView!
    @IBOutlet weak var gCommentsView: UIView!
    @IBOutlet weak var gCancelBtnOut: UIButton!
    
    
    @IBOutlet weak var gDayTextField: UITextField!
    @IBOutlet weak var gMonthTextField: UITextField!
    @IBOutlet weak var gYearTextField: UITextField!
   
    
    
    @IBOutlet weak var gHourTextField: UITextField!
    @IBOutlet weak var gMinutesTextField: UITextField!
    @IBOutlet weak var gAmPmTextField: UITextField!
    
    
    
    let picker = UIDatePicker()
    
    let obj = GenFuncs()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        createDatePicker()
        
        obj.roundtheButton(buttonname: gCancelBtnOut)
        obj.addShadowToView(viewname: gVerificationCodeView!)
        obj.addShadowToView(viewname: gServiceView)
        obj.addShadowToView(viewname: gPayementVIew)
        obj.addShadowToView(viewname: gCommentsView)
        
       
        

        
        
        self.gDayTextField.delegate = self
        self.gMonthTextField.delegate = self
        self.gYearTextField.delegate = self
        self.gHourTextField.delegate = self
        self.gMinutesTextField.delegate = self
        self.gAmPmTextField.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func donePressed()
    
    {
        gDayTextField.text = picker.date.dateToDay
        gMonthTextField.text = picker.date.dateToMonth
        gYearTextField.text = picker.date.dateToYear
        gHourTextField.text = picker.date.dateToHour
        gMinutesTextField.text = picker.date.dateToMinute
        gAmPmTextField.text = picker.date.dateToAmPm
        
        
        
        self.view.endEditing(true)
    }
    
    
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem:.done, target:nil, action:#selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        gDayTextField.inputAccessoryView = toolbar
        gMonthTextField.inputAccessoryView = toolbar
        gYearTextField.inputAccessoryView = toolbar
        gHourTextField.inputAccessoryView = toolbar
        gMinutesTextField.inputAccessoryView = toolbar
        gAmPmTextField.inputAccessoryView = toolbar
        
        obj.setBorderWidth(textfieldname: gDayTextField)
        obj.setBorderWidth(textfieldname: gMonthTextField)
        obj.setBorderWidth(textfieldname: gYearTextField)
        obj.setBorderWidth(textfieldname: gHourTextField)
        obj.setBorderWidth(textfieldname: gMinutesTextField)
        obj.setBorderWidth(textfieldname: gAmPmTextField)
        
      
        gDayTextField.inputView = picker
        gMonthTextField.inputView = picker
        gYearTextField.inputView = picker
        gHourTextField.inputView = picker
        gMinutesTextField.inputView = picker
        gAmPmTextField.inputView = picker
        
        
        
        
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    

}
