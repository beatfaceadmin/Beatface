//
//  ArtistOnboarding3.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 25/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class ArtistOnboarding3: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
   

  @IBOutlet weak var mTopConstraints: NSLayoutConstraint!
  @IBOutlet weak var mCoverImgView: UIImageView!
  @IBOutlet weak var mContactMediumTxtFld: UITextField!
  @IBOutlet weak var bProceedBtnOut: UIButton!
    @IBOutlet weak var bArtistUrlsTableView: UITableView!
    @IBOutlet weak var bUploadAttachmentsCollectionView: UICollectionView!
    @IBOutlet weak var bWorkExperienceTextField: UITextField!
    @IBOutlet weak var bArtistUrlsTextField: UITextField!
     var artist: Artist?
    var bArtistUrls = [String]()
    var bArtistAttachments = [UIImage] ()
  var bAttachmentsList = [String] ()
    let bWorkExperience = ["Beginner", "0-1 yr" ,"1-3 yrs", "3-5 yrs", "More than 5 yrs"]
    private var fileUploadAPI:FileUpload!
  var artistApi :ArtistAPI!
  var isCoverImage = false
  var coverUrl:String?
  
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = GenFuncs()
        artistApi = ArtistAPI.sharedInstance
        self.fileUploadAPI = FileUpload.sharedInstance
        obj.roundtheButton(buttonname: bProceedBtnOut)
        self.bArtistUrlsTableView.delegate = self
        self.bArtistUrlsTableView.dataSource = self
        self.bUploadAttachmentsCollectionView.delegate = self
        self.bUploadAttachmentsCollectionView.dataSource = self
        
        let imgTitle = UIImage(named: "titleBeABfArtist")
        navigationItem.titleView = UIImageView(image: imgTitle)
      
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

  @IBAction func mCoverImgAction(_ sender: UIButton) {
    self.isCoverImage = true
      self.addImage()
  }
  @IBAction func mProceedBtn(_ sender: UIButton) {
    self.collectInput()
    self.createArtist(artistDict: (self.artist?.dictionaryRepresentation())!)
  }
  
  
//  private func moveToImageCropper(image: UIImage) {
    
//    let storyboard = UIStoryboard(name: "ImageCropper", bundle: nil)
//    let imageCropperVC = storyboard.instantiateViewController(withIdentifier: "ImageCropperViewController") as! ImageCropperViewController
//    
//    
//    imageCropperVC.mode = .rectangle
//    
//    imageCropperVC.image = image
//    
//    imageCropperVC.onChooseButtonTap = { [weak self] (image) in
//      guard let image = image else { return }
//      self?.mCoverImgView.contentMode = .scaleAspectFit
//      self?.mCoverImgView.image = image
//      
//      let compressData = UIImageJPEGRepresentation(image, 0.5)
//      let compressedImage = UIImage(data: compressData!)
//      self?.fileUploadAPI.uploadImageRemote(imageh: compressedImage!){ dataImage, error -> Void in
//        if error == nil{
//          self?.coverUrl = dataImage
//        }
//        
//      }
//      
//    }
//    
//    self.present(imageCropperVC, animated: true, completion: nil)
//  }
  
  func uploadImage(image:UIImage,isCover:Bool = false) {
    let compressData = UIImageJPEGRepresentation(image, 0.5)
    let compressedImage = UIImage(data: compressData!)
    self.fileUploadAPI.uploadImageRemote(imageh: compressedImage!){ dataImage, error -> Void in
      if error == nil{
        if isCover == true{
          self.coverUrl = dataImage
        }else{
           self.bAttachmentsList.append(dataImage!)
        }
       
      }
      
    }

  }
  
  func collectInput() {
    self.artist?.contactMedium = self.mContactMediumTxtFld.text
    self.artist?.attachment = self.bAttachmentsList
     self.artist?.socialLinks = self.bArtistUrls
     self.artist?.status = "pending"
    
    if self.coverUrl != nil{
      self.artist?.coverPic = self.coverUrl!
    }else{
      kAppDelegate.showNotification(text: "Please select cover Pic")
      return
    }
    
    
  }
  
  func navigateToNext()  {
    let ArtistOnboarding3 = storyboard?.instantiateViewController(withIdentifier: "ArtistOnboarding3ID") as! ArtistOnboarding3
    ArtistOnboarding3.artist = self.artist
    self.navigationController?.pushViewController(ArtistOnboarding3, animated: true)
  }


    @IBAction func bAddArtistUrlBtn(_ sender: UIButton) {
        if bArtistUrlsTextField.text?.isEmpty == false {
            self.mTopConstraints.constant = 8
            bArtistUrls.append(bArtistUrlsTextField.text!)
            bArtistUrlsTextField.text = ""
          self.bArtistUrlsTextField.resignFirstResponder()
            self.bArtistUrlsTableView.reloadData() }
    }
    
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
  
  
  func getMediumOfContact(textfield:UITextField) {
    self.createPopUpForSelection(title: "Select Option", ValueArray: ["Gmail","SMS", "Call"], view: textfield, callback: { (value, index) in
      textfield.text = value
    })
    
  }
  
  
  func showPendingAlert()  {
    let alert = UIAlertController(title: "Alert", message: "We are really glad on your interest to join us,Someone from our team would connect you shortly.", preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      self.pushBackToHome()
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  
  // MARK: create Artist Function
  func createArtist(artistDict:NSDictionary)
    
  {
    SVProgressHUD.show(withStatus: "Please Wait")
    artistApi.createArtist(artistDetials: artistDict as! [String : Any] ){ (isSuccess,response, error) -> Void in
      SVProgressHUD.dismiss()
      
      if (isSuccess){
        if response != nil{
         self.showPendingAlert()
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
  
  
  func pushBackToHome() {
    for vc in (self.navigationController?.viewControllers ?? []) {
      if vc is HomeVc {
        _ = self.navigationController?.popToViewController(vc, animated: true)
        break
      }
    }
  }
    
    // Button to upload attachments from library
    @IBAction func bAttachmentsBtnTapped(_ sender: UIButton) {
        self.addImage()
    }
    
// Social Network Links Table methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bArtistUrls.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25.0
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistOnboarding3TableCell", for: indexPath) as! ArtistOnboarding3TableCell
        cell.bArtistUrlLabel.text = bArtistUrls[indexPath.row]
        return cell
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            bArtistUrls.remove(at: indexPath.row)
            bArtistUrlsTableView.reloadData()
        }
    }
    
    //Artist's work samples images' collection view methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bArtistAttachments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistOnboarding3CVC", for: indexPath) as! ArtistOnboarding3CVC
        cell.bArtistAttachmentImages.image = bArtistAttachments[indexPath.row]
        return cell
    }
  
  
    
    
  
    
}


extension ArtistOnboarding3: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    
    
    switch textField {
    case self.mContactMediumTxtFld:
      self.getMediumOfContact(textfield: self.mContactMediumTxtFld)
      return false
      break
    case self.bArtistUrlsTextField:
      self.mTopConstraints.constant = -100
      
      break
    default:
      print("abc")
    }
    
    
    
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
    
    return true
  }
  
  
}


extension ArtistOnboarding3:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
  
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
      
      if self?.isCoverImage == false{
        self?.bArtistAttachments.append(originalImage)
        self?.uploadImage(image: originalImage)
        self?.bUploadAttachmentsCollectionView.reloadData()
      }else{
        self?.mCoverImgView.image = originalImage
        self?.isCoverImage = false
        self?.moveToImageCropper(image: originalImage)
     
        
      }
      
    })
  }
  
}


extension ArtistOnboarding3 : CropViewControllerDelegate {
  
  private func moveToImageCropper(image: UIImage) {
    let cropController = CropViewController(croppingStyle: CropViewCroppingStyle.default, image: image)
    cropController.delegate = self
    cropController.aspectRatioPickerButtonHidden = true
    cropController.aspectRatioLockEnabled = true
    cropController.aspectRatioPreset = .preset3x1
    self.present(cropController, animated: true, completion: nil)
  }
  
  public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
    
    self.mCoverImgView.contentMode = .scaleAspectFit
          self.mCoverImgView.image = image
    
          let compressData = UIImageJPEGRepresentation(image, 0.5)
          let compressedImage = UIImage(data: compressData!)
    
    self.fileUploadAPI.uploadImageRemote(imageh: compressedImage!){ dataImage, error -> Void in
      if error == nil{
                    self.coverUrl = dataImage
      }
      
    }
    cropViewController.dismiss(animated: true, completion: nil)
  }
  
}

