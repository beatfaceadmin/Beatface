//
//  ArtistOnboarding1.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 25/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import SwiftyPickerPopover
import CoreLocation
import SwiftLocation
import GooglePlaces

class ArtistOnboarding1: UIViewController{

    @IBOutlet weak var bNextBtnOut: UIButton!
    
    
  @IBOutlet weak var mBusinessNameTxtFld: SkyFloatingLabelTextField!
  @IBOutlet weak var mTimeOutTxtFld: SkyFloatingLabelTextField!
  @IBOutlet weak var mTimeINTxtFld: SkyFloatingLabelTextField!
  @IBOutlet weak var mLocationTxtField: SkyFloatingLabelTextField!
  @IBOutlet weak var mTableViewConstraint: NSLayoutConstraint!
  @IBOutlet weak var mServiceTextField: SkyFloatingLabelTextField!
  @IBOutlet weak var mTableView: UITableView!
  @IBOutlet weak var bAvailabiltyTextField: UITextField!
    @IBOutlet weak var bAvailabilityAreaTextField: UITextField!
    @IBOutlet weak var bContactNoTextField: UITextField!
    @IBOutlet weak var bEmailIdTextField: UITextField!
    
    let obj = GenFuncs()
  var artistApi :ArtistAPI!
  var artist: Artist!
  var serviceArray: [Services]!
  var allServicelist: [String]!
  var locCor: [String]!
  var inTime = ""
  var outTime = ""
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        artistApi = ArtistAPI.sharedInstance
        serviceArray = [Services]()
        obj.roundtheButton(buttonname: bNextBtnOut)
        let imgTitle = UIImage(named: "titleBeABfArtist")
        navigationItem.titleView = UIImageView(image: imgTitle)
      self.mServiceTextField.text = "No services selected yet"
      self.createArtist(artistDict: [:])
      self.uiSetup()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  
  func uiSetup()  {
    if let phone = Constants.kUserDefaults.string(forKey: appConstants.phone){
      self.bContactNoTextField.text = phone
      self.bContactNoTextField.isUserInteractionEnabled = false
    }
    DispatchQueue.global(qos: .background).async {
     self.getAllServices()
      
      DispatchQueue.main.async {
        print("This is run on the main queue, after the previous code in outer block")
      }
    }
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
  
  // MARK: create Artist Function
  func createArtist(artistDict:Dictionary<String, AnyObject>)
    
  {
    SVProgressHUD.show(withStatus: "Please Wait")
    artistApi.createArtist(artistDetials: artistDict as! [String : String] ){ (isSuccess,response, error) -> Void in
      SVProgressHUD.dismiss()
      
      if (isSuccess){
        if response != nil{
           self.artist = response!
          if self.artist.status == "pending"{
            SVProgressHUD.dismiss()
            self.showPendingAlert()
          }
          if self.artist.status == "approved" || self.artist.status == "active" {
            SVProgressHUD.dismiss()
            self.bNextBtnOut.setTitle("Update", for: .normal)
            self.setInputs()
          }
          self.getArtistServices()
        }
       
        SVProgressHUD.dismiss()
       
     
      }else{
        SVProgressHUD.dismiss()
        self.navigationController?.popViewController(animated: true)
        if error != nil{
          kAppDelegate.showNotification(text: error!)
        }else{
          kAppDelegate.showNotification(text: "Something went wrong!")
        }
      }
      
    }
    
    
  }
  
  func showPendingAlert()  {
    let alert = UIAlertController(title: "Alert", message: "Your Request for joining us as an Artist is still in review.Someone from our team will connect you shortly.", preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      self.navigationController?.popViewController(animated: true)
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  
  func setInputs()  {
    mLocationTxtField.text = self.artist.availbilityArea 
    if let availabilityRange = self.artist.availbilityRange{
      self.bAvailabilityAreaTextField.text = String(availabilityRange)
    }
    
    self.inTime = self.artist.availbilityStart!
    self.outTime = self.artist.availbilityTill!
    let inDate = self.inTime.jsonStringToDate as Date
    let outDate = self.outTime.jsonStringToDate as Date
    self.mTimeOutTxtFld.text = inDate.dateToSmartTime
    self.mTimeINTxtFld.text = outDate.dateToSmartTime
    mLocationTxtField.text = self.artist.businessAddress
    bEmailIdTextField.text = self.artist.email
    mBusinessNameTxtFld.text = self.artist.businessName
    self.locCor = self.artist.businessCordinates
  }
  
  
  // MARK: get Artist Services
  func getArtistServices()
    
  {
    SVProgressHUD.show(withStatus: "Please Wait")
    artistApi.getAllServicesForArtist(id:"\(self.artist.id!)",pageNo: 1 ){ (response, error) -> Void in
      SVProgressHUD.dismiss()
      
     
        if error == nil{
          let serviceList = response[APIConstants.items.rawValue] as! NSArray
          self.serviceArray = Services.modelsFromDictionaryArray(array: serviceList)
          self.mTableView.reloadData()
          self.setLengthofTableView(count: self.serviceArray.count)
          self.mServiceTextField.text = "\(self.serviceArray.count) Services selected"
        
        
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
          self.mLocationTxtField.text = place?.formattedAddress!
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
        if textfield == self.mTimeINTxtFld{
          self.mTimeINTxtFld.text = selectedDate.dateToSmartTime
          self.inTime = strDate.dateStringToUTCString
        }else{
           self.mTimeOutTxtFld.text = selectedDate.dateToSmartTime
           self.outTime = strDate.dateStringToUTCString
        }
        
        
      } )
      .setDateMode(.time)
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
  
  
  @IBAction func mGetCurrentLocation(_ sender: UIButton) {
     self.getCurrentLocation()
  }
  
  // MARK: get All Services
  func getAllServices(){
    artistApi.getAllServices(){ (response, error) -> Void in
      if error == nil{
        let serviceList = response[APIConstants.items.rawValue] as! NSArray
        let serviceModelList = Services.modelsFromDictionaryArray(array: serviceList)
        self.allServicelist = [String]()
        for i in serviceModelList{
         self.allServicelist.append(i.name!)
        }
      }else{
       
        if error != nil{
          kAppDelegate.showNotification(text: error!)
        }else{
          kAppDelegate.showNotification(text: "Something went wrong!")
        }
      }
      
    }
    
  }
  
  func setLengthofTableView(count:Int)  {
    
    var countLength = count * 55
    if countLength > 165{
      countLength = 165
    }
    self.mTableViewConstraint.constant = CGFloat(countLength)
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
  }
  
    
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bNextBtn(_ sender: UIButton) {
        if bAvailabiltyTextField.text?.isEmpty == true || bAvailabilityAreaTextField.text?.isEmpty == true || bContactNoTextField.text?.isEmpty == true || bEmailIdTextField.text?.isEmpty == true || mBusinessNameTxtFld.text?.isEmpty == true {
            let alertcontroller = UIAlertController(title: "Invalid", message: "Please fill all details", preferredStyle: .alert)
            alertcontroller.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alertcontroller, animated: true)

        }
        else {
          if bEmailIdTextField.text?.isValidEmail != true{
            kAppDelegate.showNotification(text: "Please Enter Valid Email")
            return
          }
          if !(self.serviceArray.count > 0 ){
            kAppDelegate.showNotification(text: "Please Select Service you Provide")
            return
          }
          self.collectInput()
          if bNextBtnOut.title(for: .normal) == "Update"{
            self.updateArtist(artistDict: self.artist.dictionaryRepresentation())
          }else{
             self.navigateToNext()
          }
         

      
        }}
  
  
  
  func collectInput() {
    self.artist.availbilityArea = mLocationTxtField.text
    self.artist.availbilityRange = Int(bAvailabilityAreaTextField.text!.dropLast(3))
    self.artist.availbilityStart = self.inTime
    self.artist.availbilityTill = self.outTime
    self.artist.businessAddress = mLocationTxtField.text
    self.artist.email = bEmailIdTextField.text
    self.artist.businessName = mBusinessNameTxtFld.text
    self.artist.businessCordinates = self.locCor
  }
  
  func navigateToNext()  {
    let vcbeabfartist2a = storyboard?.instantiateViewController(withIdentifier: "ArtistOnboarding2ID") as! ArtistOnboarding2
    vcbeabfartist2a.artist = self.artist
    self.navigationController?.pushViewController(vcbeabfartist2a, animated: true)
  }
  

    // MARK: create Artist Function
    func updateArtist(artistDict:NSDictionary)
      
    {
      SVProgressHUD.show(withStatus: "Please Wait")
      artistApi.updateArtist(artistId: String(self.artist.id!), artistDetials: artistDict as! [String : Any] ){ (isSuccess,response, error) -> Void in
        SVProgressHUD.dismiss()
        
        if (isSuccess){
          if response != nil{
            self.navigationController?.popViewController(animated: true)
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
  
  
  func getAvailablity() {
    self.createPopUpForSelection(title: "Availability", ValueArray: ["Daily","WeekDays(Mon-Fri)","Weekend"], view: self.bAvailabiltyTextField, callback: { (value, index) in
      self.bAvailabiltyTextField.text = value
    })
  }
  
  func getAvailablityArea() {
    let kmArray = (0...80).map{"\($0) km"}
    self.createPopUpForSelection(title: "Availabe in Km", ValueArray: kmArray, view: self.bAvailabilityAreaTextField, callback: { (value, index) in
      self.bAvailabilityAreaTextField.text = value
    })
  }
  
  func showServices() {
    let resultController = self.storyboard?.instantiateViewController(withIdentifier: "ServicesPopUpVcID") as? ServicesPopUpVc
    
    self.navigationController?.definesPresentationContext = true
    
    resultController?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    resultController?.modalTransitionStyle = .crossDissolve
   
    resultController?.delegate = self
    resultController?.artist = self.artist
    resultController?.servicesArray = self.serviceArray
    resultController?.allServiceArray = self.allServicelist
    self.present(resultController!, animated: true, completion: nil)
  }
    

}

extension ArtistOnboarding1: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
   
       textField.resignFirstResponder()
  
    
    switch textField {
    case self.bAvailabiltyTextField:
      self.getAvailablity()
      return false
    case self.mLocationTxtField:
      self.pickAddress()
      return false
    case self.mTimeINTxtFld:
      self.datePicker(textfield: self.mTimeINTxtFld)
      return false
    case self.mTimeOutTxtFld:
      self.datePicker(textfield: self.mTimeOutTxtFld)
      return false
   
    case self.mServiceTextField:
      self.showServices()
      return false
 
    case self.bAvailabilityAreaTextField:
     self.getAvailablityArea()
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

extension ArtistOnboarding1:UITableViewDelegate,UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return serviceArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesPopUpCell", for: indexPath) as! ServicesPopUpCell
  let service = serviceArray![indexPath.row]
  cell.bServiceTypeLbl.text = service.name
  cell.bServiceCostLbl.text = service.cost
  cell.bServiceTimeLbl.text = service.estimatedTime
  return cell
}
  
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  return 55.0
}



}

extension ArtistOnboarding1:ServicesPopUpVCDelegate{
  func didDissmiss(sender:ServicesPopUpVc,services:[Services]){
    self.serviceArray = services
    self.mTableView.reloadData()
    self.setLengthofTableView(count: self.serviceArray.count)
  }
}


extension ArtistOnboarding1: GMSAutocompleteViewControllerDelegate {
  
  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place attributions: \(place.attributions)")
    self.mLocationTxtField.text = place.formattedAddress
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


