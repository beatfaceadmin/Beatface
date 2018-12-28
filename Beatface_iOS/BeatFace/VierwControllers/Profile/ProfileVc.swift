//
//  ProfileVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 11/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftLocation
import GooglePlaces
import SDWebImage

class ProfileVc: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

  @IBOutlet weak var mProfileImg: UIImageView!
  @IBOutlet weak var bProfilePicOutl: UIButton!
    @IBOutlet weak var bEditBtnOutl: UIButton!
    @IBOutlet weak var bNameTextField: UITextField!
    @IBOutlet weak var bMobileNoTextField: UITextField!
    @IBOutlet weak var bGenderTextField: UITextField!
    @IBOutlet weak var bDOBTextField: UITextField!
  @IBOutlet weak var bLocationTextField: UITextField!
  private var userApi : UserAPI!
  private var fileUploadAPI:FileUpload!
    var picUrl:String?
  var locCor: [String]!
    
    
    var obj:GenFuncs!
    var imagepicker : UIImagePickerController!
    let Genders = ["Male", "Female" ,"Other"]
    var pickerView = UIPickerView()
     let DOBpicker = UIDatePicker()
     var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      obj = GenFuncs()
       self.userApi = UserAPI.sharedInstance
       self.fileUploadAPI = FileUpload.sharedInstance
        obj.roundtheButton(buttonname: bProfilePicOutl)
        obj.roundtheButton(buttonname: bEditBtnOutl)
        self.bNameTextField.delegate = self
        self.bMobileNoTextField.delegate = self
        self.bLocationTextField.delegate = self
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.bMobileNoTextField.isUserInteractionEnabled = false
        bGenderTextField.inputView = pickerView
        createDatePicker()
      VCHelper().roundImageView(imageView: self.mProfileImg)
     
      if fetchProfileFromPresistance() == true{
        self.updateInputParams(user: self.user!)
      }
}
  
  
  func fetchProfileFromPresistance() -> Bool {
    
    
    if let profile = UserDefaults.standard.data(forKey: appConstants.profile){
      let userDict = NSKeyedUnarchiver.unarchiveObject(with: profile)
      let myProfile = User.init(dictionary: userDict as! NSDictionary)
      self.user = myProfile
      return true
    }
    
    return false
  }
  
  
  func updateInputParams(user:User)  {
    bNameTextField.text = user.name
    bDOBTextField.text = user.dob
    bGenderTextField.text = user.gender
    bLocationTextField.text = user.location
    if let phone = Constants.kUserDefaults.string(forKey: appConstants.phone){
      self.bMobileNoTextField.text = phone
    }
    if  user.picUrl != nil {
     self.mProfileImg.sd_setImage(with: URL.init(string:user.picUrl!.httpsExtend), placeholderImage: #imageLiteral(resourceName: "profileimage"))
 
  
    }
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    
    
    switch textField {
    case self.bLocationTextField:
      self.pickAddress()
      return false
      
    default:
      print("abc")
    }
    
    
    
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
    
    return true
  }
  
  func pickAddress() {
    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self
    present(autocompleteController, animated: true, completion: nil)
  }
    

    
    @IBAction func bSettingsBtn(_ sender: UIBarButtonItem) {
        let vcsettings = storyboard?.instantiateViewController(withIdentifier: "SettingsId") as! SettingsVc
        navigationController?.pushViewController(vcsettings, animated: true)
    }
  @IBAction func mCurrentLocation(_ sender: UIButton) {
    self.getCurrentLocation()
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
          if place != nil{
            self.locCor = [String(describing: place!.coordinates!.latitude),String(describing: place!.coordinates!.longitude)]
          }
        }
        
      }) { err in
        print(err)
      }
    }, onFail: {(e, b) -> (Void) in
      print("")
      
    })
  }
  
    @IBAction func bBackBtnProfileVc(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
  
  
  @IBAction func bProfileUpdate(_ sender: UIButton) {
  self.user?.name = self.bNameTextField.text
  self.user?.gender = self.bGenderTextField.text
  self.user?.dob = self.bDOBTextField.text
  self.user?.location = self.bLocationTextField.text
    if picUrl != nil{
      self.user?.picUrl = picUrl!
    }
 self.user?.locationCoordinates = self.locCor
  
  self.userUpdateProfile(userDict: user!)
  }
  
  
  // MARK: User SignUp Function
  func userUpdateProfile(userDict:User)
    
  {
    SVProgressHUD.show(withStatus: "Please Wait")
    userApi.userUpdateProfile(userDetials: userDict){ (isSuccess,response, error) -> Void in
      SVProgressHUD.dismiss()
      
      if (isSuccess){
        SVProgressHUD.dismiss()
        kAppDelegate.showNotification(text: "Profile Updated Successfully")
      self.navigationController?.popViewController(animated: true)
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
    
    
    @IBAction func bProfileImgBtnTapped(_ sender: UIButton) {
        self.addImage()
        
    }
  
    
    //GenderPicker
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Genders.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bGenderTextField.text = Genders[row]
        bGenderTextField.resignFirstResponder()
    }
    
    //DatePicker
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        bDOBTextField.inputAccessoryView = toolbar
        bDOBTextField.inputView = DOBpicker
        
        DOBpicker.datePickerMode = .date
    }
    
    
    @objc func donePressed() {
        //formatdate
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: DOBpicker.date)
        
        
        bDOBTextField.text = "\(dateString)"
        self.view.endEditing(true)

    
    }}




extension ProfileVc: GMSAutocompleteViewControllerDelegate {
  
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


extension ProfileVc:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
  
  func addImage(){
    let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
    let takePic = UIAlertAction(title: "Take Photo", style: .default,handler: {
      (alert: UIAlertAction!) -> Void in
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.sourceType = UIImagePickerControllerSourceType.camera
      self.present(myPickerController, animated: true, completion: nil)
      
    })
    
    let choseAction = UIAlertAction(title: "Choose from Library",style: .default,handler: {
      (alert: UIAlertAction!) -> Void in
      
      let myPickerController = UIImagePickerController()
      myPickerController.delegate = self
      myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
      self.present(myPickerController, animated: true, completion: nil)
      
      
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
      (alert: UIAlertAction!) -> Void in
    })
    optionMenu.addAction(takePic)
    optionMenu.addAction(choseAction)
    optionMenu.addAction(cancelAction)
    self.present(optionMenu, animated: true, completion: nil)
  }
  
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    print("abc")
    guard let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
    
    self.dismiss(animated: false, completion: { [weak self] in
      
      self?.bProfilePicOutl.setBackgroundImage(originalImage, for: .normal)
      self?.moveToImageCropper(image: originalImage)
    })
  }
  
}


extension ProfileVc : CropViewControllerDelegate {
  
  private func moveToImageCropper(image: UIImage) {
    let cropController = CropViewController(croppingStyle: CropViewCroppingStyle.default, image: image)
    cropController.delegate = self
    cropController.aspectRatioPickerButtonHidden = true
    cropController.aspectRatioLockEnabled = true
    cropController.aspectRatioPreset = .presetSquare
    self.present(cropController, animated: true, completion: nil)
  }
  
  public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
    self.bProfilePicOutl.contentMode = .scaleAspectFit
    self.bProfilePicOutl.setBackgroundImage(image, for: .normal)
    
    
    let compressData = UIImageJPEGRepresentation(image, 0.5)
    let compressedImage = UIImage(data: compressData!)
    self.fileUploadAPI.uploadImageRemote(imageh: compressedImage!){ dataImage, error -> Void in
      if error == nil{
        self.picUrl = dataImage
      }
      
    }
    cropViewController.dismiss(animated: true, completion: nil)
  }
  
}
    


