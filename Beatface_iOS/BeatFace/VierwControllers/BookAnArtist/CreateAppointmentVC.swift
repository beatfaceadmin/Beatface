//
//  CreateAppointmentVC.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 08/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import CoreLocation
import SwiftLocation
import GooglePlaces

class CreateAppointmentVC: UIViewController {
   

  
    
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
  
    var services:[String]!
   var artist: Artist!
   var serviceArray: [Services]!
  var selectedService: Services?
  var selectedDate = ""
    var helper:GenFuncs!
  var appointmentApi :AppointmentAPI!
  var validator:Validators!
    var locCor: [String]!
  var price:Float! = 0.0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        helper = GenFuncs()
       validator = Validators()
        helper.roundtheButton(buttonname: bContinueBtnOutl)
      appointmentApi = AppointmentAPI.sharedInstance
        
        self.bDayTextField.delegate = self
        self.bMonthTextField.delegate = self
        self.bYearTextField.delegate = self
        self.bHourTextField.delegate = self
        self.bMinutesTextField.delegate = self
        self.bAmPmTextField.delegate = self
        self.uiInputs()
    
        
     }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
  
  func uiInputs()  {
    self.title = self.artist.businessName
    self.bArtistName.text = self.artist.user?.name
    self.mArtistLocationLbl.text = self.artist.user?.location
  }
  
  @IBAction func mCurrentLocation(_ sender: UIButton) {
    self.getCurrentLocation()
  }
  
  // MARK: create Appointment Function
  func createAppointment(appointmentDict:NSDictionary)
    
  {
    SVProgressHUD.show(withStatus: "Please Wait")
    appointmentApi.createAppointment(appointmentDetials: appointmentDict as! [String : Any] ){ (isSuccess,response, error) -> Void in
      SVProgressHUD.dismiss()
      
      if (isSuccess){
        if response != nil{
          for vc in (self.navigationController?.viewControllers ?? []) {
            if vc is BookArtistVc {
              _ = self.navigationController?.popToViewController(vc, animated: true)
              break
            }
          }
          
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
          self.locCor = [String(describing: place!.coordinates!.latitude),String(describing: place!.coordinates!.longitude)]
        
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
      self.price = selectedService!.cost!.floatValue
    }
    
  }


  
  @IBAction func mUrgentActionBtn(_ sender: UIButton) {
    self.mCheckBtn.isSelected = !self.mCheckBtn.isSelected
    if self.selectedService != nil{
    if mCheckBtn.isSelected ==  true{
      self.price = self.price + 25
      self.mServicePrice.text = "$ \(self.price!)"
    }else{
      self.price = self.price - 25
      self.mServicePrice.text = "$ \(self.price!)"
    }
    }
  }
  
    
    //Back Navigation Btn
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Continue Button Tapped
    
    @IBAction func bContinueBtnTapped(_ sender: UIButton) {
//        let paymentdetailsvc = storyboard?.instantiateViewController(withIdentifier: "PaymentDetailsId") as! PaymentDetailsVc
//        self.navigationController?.pushViewController(paymentdetailsvc, animated: true)
      guard validator.validators(TF1: self.mLocationRemarkTxtFld,fieldName: "Landmark") == false
        || validator.validators(TF1: self.bLocationTextField,fieldName: "Location") == false
        || validator.validators(TF1: self.bAmPmTextField,fieldName: "Time") == false
        else {
          if selectedService == nil{
            kAppDelegate.showNotification(text: "Make Sure to select any service")
          }
          
          self.createAppointment(appointmentDict:self.collectInput().dictionaryRepresentation())
          
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
    appointment!.price = self.price
    appointment!.serviceId = "\(self.selectedService!.id!)"
    appointment!.artistId = "\(self.artist.id!)"
     appointment!.addressCordinates = self.locCor
    
    
    return appointment!
    
  }
  
  
}

extension CreateAppointmentVC: UITextFieldDelegate{
  
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
  
  
}

extension CreateAppointmentVC: GMSAutocompleteViewControllerDelegate {
  
  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place attributions: \(place.attributions)")
    self.bLocationTextField.text = place.formattedAddress
    self.locCor = [String(describing: place.coordinate.longitude),String(describing: place.coordinate.longitude)]
    
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
