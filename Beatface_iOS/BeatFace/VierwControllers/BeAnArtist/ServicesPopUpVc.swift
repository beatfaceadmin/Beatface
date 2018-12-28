//
//  ServicesPopUpVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 08/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

protocol ServicesPopUpVCDelegate: class {
  func didDissmiss(sender:ServicesPopUpVc,services:[Services])
}

class ServicesPopUpVc: UIViewController, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {
   
    

    
  @IBOutlet weak var mAddServiceBtn: UIButton!
  @IBOutlet weak var mAddNewServiceView: UIStackView!
  @IBOutlet weak var mTotalServiceLbl: UILabel!
  @IBOutlet weak var mRootview: UIView!
  @IBOutlet weak var bServicesTableView: UITableView!
    @IBOutlet weak var bDoneBtnOutl: UIButton!
    @IBOutlet weak var bNameOfServiceTextField: UITextField!
    @IBOutlet weak var bEstimteTimeTextField: UITextField!
    @IBOutlet weak var bChargesTextField: UITextField!
   weak var delegate:ServicesPopUpVCDelegate?
     var artist: Artist!
  var servicesArray: [Services]?
  var allServiceArray: [String]?
  var obj:GenFuncs!
   var artistApi :ArtistAPI!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      obj = GenFuncs()
      artistApi = ArtistAPI.sharedInstance
        self.bServicesTableView.delegate = self
        self.bServicesTableView.dataSource = self
        obj.roundtheButton(buttonname: bDoneBtnOutl)
      obj.roundtheButton(buttonname: mAddServiceBtn)
      let vcHelper = VCHelper()
      mRootview = vcHelper.addShadowAndBoderUIView(view: mRootview)
     let tap = UITapGestureRecognizer(target: self, action: #selector(ServicesPopUpVc.handleTap(sender:)))
    tap.delegate = self
       self.mAddNewServiceView.addGestureRecognizer(tap)
       self.bServicesTableView.reloadData()
       self.mTotalServiceLbl.text = "\(self.servicesArray!.count) Service(s)"
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
  
  @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
   self.addNewServiceName()
    
  }
   
    
    @IBAction func bDoneBtnTapped(_ sender: UIButton) {
      self.delegate?.didDissmiss(sender: self,services: servicesArray!)
        dismiss(animated: true, completion: nil)
    }
    
  @IBAction func mAddServiceBtn(_ sender: UIButton) {
    if bNameOfServiceTextField.text?.isEmpty == false && bEstimteTimeTextField.text?.isEmpty == false && bChargesTextField.text?.isEmpty == false {
     let serviceDict = Services.init(dictionary: NSDictionary())
      serviceDict?.name = bNameOfServiceTextField.text
       serviceDict?.cost = bChargesTextField.text
       serviceDict?.estimatedTime = bEstimteTimeTextField.text
      serviceDict?.serviceType = "Full"
      serviceDict?.artistId = "\(self.artist.id!)"
      self.createArtistService(serviceDict: serviceDict?.dictionaryRepresentation() as! [String : String])
       self.mTotalServiceLbl.text = "\(self.servicesArray!.count) Service(s)"
      self.bServicesTableView.reloadData()
    }
  }
  
    
    @IBAction func bAddServiceBtnTapped(_ sender: UIButton) {
        
        
    }
  
  
  // MARK: create Artist Service Function
  func createArtistService(serviceDict:[String : String])
    
  {
    SVProgressHUD.show(withStatus: "Please Wait")
    artistApi.createArtistService(serviceDetials: serviceDict  ){ (isSuccess,response, error) -> Void in
      SVProgressHUD.dismiss()
      
      if (isSuccess){
        if response != nil{
          self.servicesArray?.append(response!)
          self.mTotalServiceLbl.text = "\(self.servicesArray?.count) Service(s)"
          self.bEstimteTimeTextField.text = ""
          self.bChargesTextField.text = ""
          self.bNameOfServiceTextField.text = ""
          self.bServicesTableView.reloadData()
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
  
  func getServiceList() {
    var stringArry = [String]()
    if self.allServiceArray != nil{
      stringArry = self.allServiceArray!
    }else{
      stringArry = ["Nail Art","Pedicure","Menicure","Hair Wash","Spa","Hair Smoothening"]
    }
    self.createPopUpForSelection(title: "Select Service", ValueArray: stringArry, view: self.bNameOfServiceTextField, callback: { (value, index) in
      self.bNameOfServiceTextField.text = value
    })
  }
  
  func getEstimatedTime() {
    self.createPopUpForSelection(title: "Estimated Time", ValueArray: ["less than 30 min","less than 1 hr","1hr - 2hrs","2hrs - 3hrs","3hrs - 5hrs","5hrs - 7hrs", "8hrs+", "1 day"], view: self.bEstimteTimeTextField, callback: { (value, index) in
      self.bEstimteTimeTextField.text = value
    })
  }
  
  
  func addNewServiceName()  {
    let alert = UIAlertController(title: "Add New Service", message: "Enter name of service below", preferredStyle: .alert)
    
 
    alert.addTextField { (textField) in
      textField.placeholder = "For eg. makeup, full face etc"
    }
    
   
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
      let textField = alert?.textFields![0]
     
      if textField?.text != nil {
        self.bNameOfServiceTextField.text = textField?.text
      }
      textField?.resignFirstResponder()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
      
    }))
    
   
    self.present(alert, animated: true, completion: nil)
  }
  
 
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesPopUpCell", for: indexPath) as! ServicesPopUpCell
      let service = servicesArray![indexPath.row]
        cell.bServiceTypeLbl.text = service.name
        cell.bServiceCostLbl.text = service.cost
        cell.bServiceTimeLbl.text = service.estimatedTime
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    

   
}

extension ServicesPopUpVc: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
   
    
    
    switch textField {
    case self.bNameOfServiceTextField:
       textField.resignFirstResponder()
      self.getServiceList()
      return false
    case self.bEstimteTimeTextField:
       textField.resignFirstResponder()
      self.getEstimatedTime()
      return false

    case self.bChargesTextField:
      textField.keyboardType = .numbersAndPunctuation
      
      
      return true

    default:
      print("abc")
    }
    
    
    
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
    
    return true
  }
  
  
}
