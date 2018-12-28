//
//  AppointmentDetailVC.swift
//  BeatFace
//
//  Created by dEEEP on 09/04/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//


  import UIKit
  import SwiftyPickerPopover
  import CoreLocation
  import SwiftLocation
  import GooglePlaces
import BraintreeDropIn
import Braintree
  
  class AppointmentDetailVC: UIViewController {
    
    
    
    
    @IBOutlet weak var mCancelBtn: UIButton!
    @IBOutlet weak var mStrtBtn: UIButton!
    @IBOutlet weak var mCommentTxtField: UITextField!
    @IBOutlet weak var mCheckBtn: UIButton!
    @IBOutlet weak var mServicePrice: UILabel!
    @IBOutlet weak var mArtistLocationLbl: UILabel!
    @IBOutlet weak var mLocationRemarkTxtFld: UITextField!
    @IBOutlet weak var bContinueBtnOutl: UIButton!
    @IBOutlet weak var bArtistName: UILabel!
    @IBOutlet weak var bSelectAServiceTextField: UITextField!
    @IBOutlet weak var bLocationTextField: UITextField!
    @IBOutlet weak var bDayTextField: UITextField!
    @IBOutlet weak var bMonthTextField: UITextField!
    @IBOutlet weak var bYearTextField: UITextField!
    @IBOutlet weak var bHourTextField: UITextField!
    @IBOutlet weak var bMinutesTextField: UITextField!
    @IBOutlet weak var bAmPmTextField: UITextField!
    
    @IBOutlet weak var mUrgentCheckBtn: UIButton!
    @IBOutlet weak var VF1: UITextField!
    @IBOutlet weak var VF2: UITextField!
    @IBOutlet weak var VF3: UITextField!
    @IBOutlet weak var VF4: UITextField!
    @IBOutlet weak var VF5: UITextField!

    
    
    var services:[String]!
    var artist: Artist!
    var serviceArray: [Services]!
    var selectedService: Services?
    var selectedDate = ""
    var helper:GenFuncs!
    var isEdit =  false
   var isStarted =  false
    var appointmentApi :AppointmentAPI!
    var validator:Validators!
    var appointment: Appointment!
    var isArtist = false
    
    
    override func viewDidLoad() {
      
      super.viewDidLoad()
      helper = GenFuncs()
     
      validator = Validators()
    
      appointmentApi = AppointmentAPI.sharedInstance

      self.uiInputs()
      self.setDelegateView()
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      self.isEdit(isEditParam: isEdit)
      if isArtist == true{
         self.setActionButtonForArtist()
      }else{
        self.setActionButtonForUser()
      }
     
   
    }
    
    func setActionButtonForArtist() {
      var btnTitle = ""

        
        switch self.appointment.status! {
        case "pending":
          btnTitle = "APPROVE"
          self.mStrtBtn.backgroundColor = UIColor.greenDot()
          //action
          break
        case "active":
          btnTitle = "START"
          self.mStrtBtn.backgroundColor = UIColor.greenDot()
          //action
          break
        case "start":
          btnTitle = "ACTIVE"
          self.mStrtBtn.backgroundColor = UIColor.orange
          //No action
          break
        case "complete":
          btnTitle = "COMPLETED"
          self.mStrtBtn.backgroundColor = UIColor.greenDot()
          //No action
          break
        case "cancel":
          btnTitle = "CANCELLED"
          self.mStrtBtn.backgroundColor = UIColor.redDot()
          //No action
          break
        default:
          btnTitle = "NONE"
          
        }
   
     self.mStrtBtn.setTitle(btnTitle, for: .normal)
    }
    
    
    func setActionButtonForUser() {
      var btnTitle = ""
 
        
        switch self.appointment.status! {
        case "pending":
          btnTitle = "REQUESTED"
          //No action
          self.mStrtBtn.backgroundColor = UIColor.orange
          break
        case "active":
          btnTitle = "EDIT"
           self.mStrtBtn.backgroundColor = UIColor.BtnColor()
          //action
          break
        case "start":
          btnTitle = "MARK DONE"
           self.mStrtBtn.backgroundColor = UIColor.greenDot()
          //action
          break
        case "complete":
          btnTitle = "COMPLETED"
          self.mStrtBtn.backgroundColor = UIColor.greenDot()
          //No action
          break
        case "cancel":
          btnTitle = "CANCELLED"
          self.mStrtBtn.backgroundColor = UIColor.redDot()
          //No action
          break
        default:
          btnTitle = "NONE"
          
        }
      
      self.mStrtBtn.setTitle(btnTitle, for: .normal)
    }
    
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      
    }
    
    func isEdit(isEditParam:Bool)  {
      self.bDayTextField.isUserInteractionEnabled = isEditParam
      self.bMonthTextField.isUserInteractionEnabled = isEditParam
      self.bYearTextField.isUserInteractionEnabled = isEditParam
      self.bHourTextField.isUserInteractionEnabled = isEditParam
      self.bMinutesTextField.isUserInteractionEnabled = isEditParam
      self.bAmPmTextField.isUserInteractionEnabled = isEditParam
      self.VF1.isUserInteractionEnabled = !isEditParam
      self.VF2.isUserInteractionEnabled = !isEditParam
      self.VF3.isUserInteractionEnabled = !isEditParam
      self.VF4.isUserInteractionEnabled = !isEditParam
      self.VF5.isUserInteractionEnabled = !isEditParam
      
      self.bArtistName.isUserInteractionEnabled = isEditParam
      self.mArtistLocationLbl.isUserInteractionEnabled = isEditParam
      self.bLocationTextField.isUserInteractionEnabled = isEditParam
      self.mLocationRemarkTxtFld.isUserInteractionEnabled = isEditParam
      self.mCommentTxtField.isUserInteractionEnabled = isEditParam
      self.bSelectAServiceTextField.isUserInteractionEnabled = false
      self.mServicePrice.isUserInteractionEnabled = isEditParam
    }
    
    func setDelegateView()  {
      self.bDayTextField.delegate = self
      self.bMonthTextField.delegate = self
      self.bYearTextField.delegate = self
      self.bHourTextField.delegate = self
      self.bMinutesTextField.delegate = self
      self.bAmPmTextField.delegate = self
      self.VF1.delegate = self
      self.VF2.delegate = self
      self.VF3.delegate = self
      self.VF4.delegate = self
      self.VF5.delegate = self
      
      self.createTxtFld(btn: VF1)
      self.createTxtFld(btn: VF2)
      self.createTxtFld(btn: VF3)
      self.createTxtFld(btn: VF4)
      self.createTxtFld(btn: VF5)
     
    }
    
    func uiInputs()  {
      self.title = self.artist.businessName
      self.bArtistName.text = self.artist.businessName
      self.mArtistLocationLbl.text = self.artist.businessAddress
      self.bLocationTextField.text = self.appointment.address
      self.mLocationRemarkTxtFld.text = self.appointment.addressDescription
      self.selectedDate = self.appointment.time!
      self.setDateInTextField(date: self.selectedDate.jsonStringToDate as! Date)
      self.mCommentTxtField.text = self.appointment.comments
      self.bSelectAServiceTextField.text = self.selectedService?.name
       self.mServicePrice.text = self.selectedService?.cost
      let characters = Array(appointment.code!.characters)
      VF1.text = String(characters[0])
       VF2.text = String(characters[1])
       VF3.text = String(characters[2])
      if isArtist == false{
        VF4.text = String(characters[3])
        VF5.text = String(characters[4])
      }
      
    }
    
    func createTxtFld(btn:UITextField) {
      btn.layer.borderWidth = 1.0
      btn.layer.borderColor = UIColor.white.cgColor
      btn.layer.masksToBounds = true
    }
    
    @IBAction func mCurrentLocation(_ sender: UIButton) {
      self.getCurrentLocation()
    }
    
    @IBAction func mCancelActionBtn(_ sender: UIBarButtonItem) {
      
      self.showCancelAlert()
    }
    
    func showCancelAlert()  {
      let alert = UIAlertController(title: "Alert", message: "Are you sure you want to cancel this appointment ?", preferredStyle: UIAlertControllerStyle.alert)
      
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
         self.updateAppointmentStatus(appointmentStatus: "cancel")
      }))
      alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
        
      }))
      
      self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: create Appointment Function
    func updateAppointment(appointmentDict:NSDictionary)
      
    {
      SVProgressHUD.show(withStatus: "Please Wait")
      appointmentApi.updateAppointment(appointmentID:"\(self.appointment!.id!)",appointmentDetials: appointmentDict as! [String : Any] ){ (isSuccess,response, error) -> Void in
        SVProgressHUD.dismiss()
        
        if (isSuccess){
          if response != nil{
             self.setBottomBar()
          }
          
          SVProgressHUD.dismiss()
          
          
        }else{
          SVProgressHUD.dismiss()
          if error != nil{
            kAppDelegate.showNotification(text: error!)
          }else{
            kAppDelegate.showNotification(text: "Something went wrong!")
          }
        }
        
      }
      
      
    }
    
    
    // MARK: Update Appointment Status Function
    func updateAppointmentStatus(appointmentStatus:String)
      
    {
      SVProgressHUD.show(withStatus: "Please Wait")
      let appointment = ["appointmentId" : self.appointment.id!,
                         AppointmentAttributes.status.rawValue : appointmentStatus,
                         AppointmentAttributes.code.rawValue : self.appointment.code!] as [String : Any]
      appointmentApi.updateAppointmentStatus(appointmentDetail:appointment){ (isSuccess, error) -> Void in
        SVProgressHUD.dismiss()
        
        if (isSuccess){
          
          if appointmentStatus == "cancel"{
            self.navigationController?.popViewController(animated: true)
            return
          }
          
          if appointmentStatus == "complete"{
            
          self.fetchClientToken()
           
            return
          }
          if appointmentStatus == "active"{
            
             self.mStrtBtn.setTitle("START", for: .normal)
            self.mStrtBtn.backgroundColor = UIColor.greenDot()
            return
          }
         
          self.isStarted = true
          
          self.mStrtBtn.setTitle("ACTIVE", for: .normal)
           self.mStrtBtn.backgroundColor = UIColor.greenDot()
          SVProgressHUD.dismiss()
          
          
        }else{
          SVProgressHUD.dismiss()
          if error != nil{
            kAppDelegate.showNotification(text: error!)
          }else{
            kAppDelegate.showNotification(text: "Something went wrong!")
          }
        }
        
      }
      
      
    }
    
    
    func paymenntnounce(detials: [String:Any])   {
      let urlString =  beatfaceConfig.mBaseUrl1 + "braintrees/receiveNonceFromClient"
      
      RemoteRepository().remotePOSTServiceWithParameters(urlString: urlString, params: detials as Dictionary<String, AnyObject>) { (data, error) -> Void in
        print(data)
         self.navigationController?.popViewController(animated: true)
        
      }
    }
    
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
      let request =  BTDropInRequest()
      request.paypalDisabled = false
      let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
      { (controller, result, error) in
        if (error != nil) {
          print("ERROR")
        } else if (result?.isCancelled == true) {
          print("CANCELLED")
        } else if let result = result {
          // Use the BTDropInResult properties to update your UI
          result.paymentOptionType = .payPal
          //         result.paymentOptionType
          //         result.paymentMethod
          //         result.paymentIcon
          //         result.paymentDescription
          print(result.paymentMethod)
          
          let comment = ["amount" : 10,"payment_method_nonce":result.paymentMethod?.nonce] as [String : Any]
          self.paymenntnounce(detials: comment)
          
        }
        controller.dismiss(animated: true, completion: nil)
      }
      self.present(dropIn!, animated: true, completion: nil)
    }
    
    
    func fetchClientToken() {
      
      let url = beatfaceConfig.mBaseUrl1 + "braintrees/getClientToken"
      
      RemoteRepository().remoteGETService(urlString: url) { (data, error) -> Void in
        if data != nil{
          let resdata = data![APIConstants.data.rawValue] as! Dictionary<String, AnyObject>
          let clientToken = resdata["clientToken"] as! String
          self.showDropIn(clientTokenOrTokenizationKey: clientToken)
        }
        
      }
      
    }
    
    
    func setDateInTextField(date:Date)
    {
      self.view.endEditing(true)
      bDayTextField.text = date.dateToDay
      bMonthTextField.text = date.dateToMonth
      bYearTextField.text = date.dateToYear
      bHourTextField.text = date.dateToHour
      bMinutesTextField.text = date.dateToMinute
      bAmPmTextField.text = date.dateToAmPm
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
    
    func pickAddress() {
      let autocompleteController = GMSAutocompleteViewController()
      autocompleteController.delegate = self
      present(autocompleteController, animated: true, completion: nil)
    }
    
    func getCurrentLocation()  {
      
      
      let locate = Locator
      locate.currentPosition(accuracy: .city, onSuccess: {loc in
        print(loc.coordinate)
        Locator.api.googleAPIKey = beatfaceConfig.googleAPIKey
        let coordinates = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)
        Locator.location(fromCoordinates: coordinates, using: .google, onSuccess: { places in
          print(places)
          
          DispatchQueue.main.async {
            let place = places.first
            self.bLocationTextField.text = place?.formattedAddress!
          }
          
        }) { err in
          print(err)
        }
      }, onFail: {(e, b) -> (Void) in
        print("")
        
      })
    }
    
    func datePicker(textfield:UITextField)  {
      let p = DatePickerPopover(title: "Select Time")
        .setLocale(identifier: "en_US") //en_GB is dd-MM-YYYY. en_US is MM-dd-YYYY. They are both in English.
        .setDoneButton(action: { popover, selectedDate in
          print("selectedDate \(selectedDate)")
          let strDate = "\(selectedDate)"
          self.selectedDate = strDate.dateStringToUTCString
          self.setDateInTextField(date: selectedDate)
        } )
        .setDateMode(.dateAndTime)
        .setMinimumDate(Date())
        .setCancelButton(action: { _, _ in print("cancel")})
        .setClearButton(action: { popover, selectedDate in
          print("clear")
          //Rewind
          popover.setSelectedDate(Date()).reload()
          //Instead, hide it.
          //                popover.disappear()
        })
      
      p.appear(originView: textfield, baseViewController: self)
      p.disappearAutomatically(after: 3.0)
      
    }
    
    func getServiceList() {
      self.createPopUpForSelection(title: "Select Service", ValueArray: services, view: self.bSelectAServiceTextField, callback: { (value, index) in
        self.bSelectAServiceTextField.text = value
        self.setSelectedServicePrice(value: value)
      })
    }
    
    func setSelectedServicePrice(value: String?)  {
      for service in serviceArray{
        if service.name == value {
          self.selectedService = service
        }
        
      }
      if selectedService != nil{
        self.mServicePrice.text = "$ \(selectedService!.cost!)"
      }
      
    }
    
    
    
    @IBAction func mUrgentActionBtn(_ sender: UIButton) {
      self.mCheckBtn.isSelected = !self.mCheckBtn.isSelected
    }
    
    @IBAction func mCancelBtnAction(_ sender: UIButton) {
      if self.mCancelBtn.titleLabel?.text == "CANCEL"{
       self.updateAppointmentStatus(appointmentStatus: "cancel")
        return
      }
      self.setBottomBar()
    }
    
    func setBottomBar() {
      self.isEdit =  !self.isEdit
      if self.isEdit ==  true{
        self.mStrtBtn.setTitle("SAVE", for: .normal)
      }else{
        self.mStrtBtn.setTitle("EDIT", for: .normal)
      }
      
      self.viewWillAppear(true)
    }
    
    @IBAction func mStartBtnAction(_ sender: UIButton) {
      if self.mStrtBtn.titleLabel?.text == "SAVE"{
        self.updateAppointment()
        return
      }
      
      
      if self.mStrtBtn.titleLabel?.text == "EDIT"{
        self.setBottomBar()
        return
      }
      
      if self.mStrtBtn.titleLabel?.text == "START"{
        if self.fetchValueofOTP() == true{
           self.updateAppointmentStatus(appointmentStatus: "start")
        }
      
        return
      }
      
      if self.mStrtBtn.titleLabel?.text == "MARK DONE"{
        self.updateAppointmentStatus(appointmentStatus: "complete")
        return
      }
      
      if self.mStrtBtn.titleLabel?.text == "APPROVE"{
        self.updateAppointmentStatus(appointmentStatus: "active")
        return
      }

      

    }
    
    func fetchValueofOTP() -> Bool  {
      let otp = self.VF1.text! + self.VF2.text!
      let otp2 = self.VF3.text! + self.VF4.text!
      var otp3 = otp + otp2 + self.VF5.text! as! String
      if otp3 != self.appointment.code {
        kAppDelegate.showNotification(text: "Make Sure to enter valid OTP.")
        return false
      }
      return true
    }
    
    //Back Navigation Btn
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
      self.navigationController?.popViewController(animated: true)
    }
    
    //Continue Button Tapped
    @IBAction func bContinueBtnTapped(_ sender: UIButton) {
      //        let paymentdetailsvc = storyboard?.instantiateViewController(withIdentifier: "PaymentDetailsId") as! PaymentDetailsVc
      //        self.navigationController?.pushViewController(paymentdetailsvc, animated: true)
    }
    
    func updateAppointment() {
      guard validator.validators(TF1: self.mLocationRemarkTxtFld,fieldName: "Landmark") == false
        || validator.validators(TF1: self.bLocationTextField,fieldName: "Location") == false
        || validator.validators(TF1: self.bAmPmTextField,fieldName: "Time") == false
        else {
          if selectedService == nil{
            kAppDelegate.showNotification(text: "Make Sure to select any service")
          }
          
          self.updateAppointment(appointmentDict:self.collectInput().dictionaryRepresentation())
          
          return
      }
    }
    
    
    func collectInput() -> Appointment {
      let appointment = Appointment.init(dictionary: NSDictionary())
      appointment!.address = bLocationTextField.text
      appointment!.addressDescription = mLocationRemarkTxtFld.text
      appointment!.time = selectedDate
      appointment?.comments = self.mCommentTxtField.text
      appointment?.isUrgent = mCheckBtn.isSelected
      appointment!.address = bLocationTextField.text
      appointment!.price = self.selectedService?.cost!.floatValue
      appointment!.serviceId = "\(self.selectedService!.id!)"
      appointment!.artistId = "\(self.artist.id!)"
      
      
      return appointment!
      
    }
    
    
  }
  
  extension AppointmentDetailVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
      textField.resignFirstResponder()
      return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      
      textField.resignFirstResponder()
      
      
      switch textField {
      case self.bSelectAServiceTextField:
        self.getServiceList()
        return false
      case self.bLocationTextField:
        self.pickAddress()
        return false
      case self.bDayTextField:
        self.datePicker(textfield:bDayTextField)
        return false
      case self.bHourTextField:
        self.datePicker(textfield:bHourTextField)
        return false
      case self.bMonthTextField:
        self.datePicker(textfield:bMonthTextField)
        return false
      case self.bMinutesTextField:
        self.datePicker(textfield:bMinutesTextField)
        return false
      case self.bYearTextField:
        self.datePicker(textfield:bYearTextField)
        return false
      case self.bAmPmTextField:
        self.datePicker(textfield:bAmPmTextField)
        return false
        
        
      default:
        print("abc")
      }
      
      
      
      UIView.animate(withDuration: 0.5) {
        self.view.layoutIfNeeded()
      }
      
      return true
    }
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      //On inputing value to textfield
      if ((textField.text?.count)! < 1  && string.count > 0){
        if(textField == self.VF4){
          self.VF5.becomeFirstResponder()
        }
        
        
        if (textField == self.VF5 ){
          self.view.endEditing(true)
          
          
        }
        
        textField.text = string
        
        return false
        
        
      }else if ((textField.text?.count)! >= 1  && string.count == 0){
        // on deleting value from Textfield
        if(textField == self.VF5){
          self.VF4.becomeFirstResponder()
        }
        textField.text = ""
        return false
      }else if ((textField.text?.count)! >= 1  ){
        textField.text = string
        return false
      }
      return true
    }
    
    
  }
  
  extension AppointmentDetailVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
      print("Place name: \(place.name)")
      print("Place address: \(place.formattedAddress)")
      print("Place attributions: \(place.attributions)")
      self.bLocationTextField.text = place.formattedAddress
      dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
      // TODO: handle the error.
      print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
      dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}








