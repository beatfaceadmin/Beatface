//
//  AppointmentsVC.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 11/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class AppointmentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var mArtistTriggerButton: UIButton!
  @IBOutlet weak var mEmptyList: UILabel!
  @IBOutlet weak var bAppointmentTableView: UITableView!
  private var appointmentApi : AppointmentAPI!
  private var appointmentArray : [Appointment]!
  @IBOutlet weak var mFilterButton: UIButton!
  var valueArray = ["All","Upcoming","Cancelled","Past"]
  var artistID:Int?
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
      appointmentArray = []
      self.appointmentApi = AppointmentAPI.sharedInstance
        self.bAppointmentTableView?.delegate = self
        self.bAppointmentTableView?.dataSource = self
       VCHelper().createRoundButtonWithBoder(btn: self.mFilterButton, boderWidth: 1, boderColor: UIColor.BaseTint().cgColor, cornerRadius: 10)
      let artistStatus = Constants.kUserDefaults.string(forKey: appConstants.artistStatus)
      if artistStatus == "approved"{
        if let artistID = Constants.kUserDefaults.integer(forKey: appConstants.artistID) as? Int {
         self.artistID = artistID
          self.mArtistTriggerButton.isSelected = true
           self.mArtistTriggerButton.setTitleColor(UIColor.lightGray, for: .selected)
        }
      }else{
        self.mArtistTriggerButton.isUserInteractionEnabled = false
      }
    }
  


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  @IBAction func mArtistTriggerAction(_ sender: UIButton) {
    self.mArtistTriggerButton.isSelected = !self.mArtistTriggerButton.isSelected
    self.mArtistTriggerButton.setTitleColor(UIColor.lightGray, for: .normal)
    self.mArtistTriggerButton.setTitleColor(UIColor.lightGray, for: .selected)
    self.getAllAppointment()
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
  
  @IBAction func mFilterBtnAction(_ sender: UIButton) {
    self.createPopUpForSelection(title: "Select Filter", ValueArray: valueArray, view: self.mFilterButton, callback: { (value, index) in
     self.mFilterButton.setTitle(value, for: .normal)
      self.checkStatusFilter()
    })
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.mEmptyList.isHidden = false
    self.getAllAppointment()
  }
  
  
  func checkStatusFilter()  {
    switch self.mFilterButton.title(for: .normal) {
    case "All"?:
      self.getAllAppointment()
      break
    case "Upcoming"?:
      self.getAllAppointment(filter:"")
     break
    case "Cancelled"?:
      self.getAllAppointment(filter:"cancel")
     break
    case "Past"?:
      self.getAllAppointment(filter:"complete")
      break



    default:
      print("abc")
    }
  }
  
  
  func getAllAppointment(searchString:String = "userId=",pageNumber:Int = 1,filter:String = "all") {
   let id = Constants.kUserDefaults.string(forKey: appConstants.id)
    var searString = searchString + id!
    if self.artistID != nil && self.mArtistTriggerButton.isSelected == true{
      searString = "artistId=" + String(describing: self.artistID!)
    }
    if filter != "all"{
      searString = searString + "&status=\(filter)"
    }
    appointmentApi.getAllAppointment(name: searString,pageNo: pageNumber) { (data, error) in
      if data[APIConstants.isSuccess.rawValue] as! Bool == true {
        let appointmentList = data[APIConstants.items.rawValue] as! NSArray
        
        if appointmentList.count > 0 {
          self.mEmptyList.isHidden = true
        }else{
          self.mEmptyList.isHidden = false
        }
        self.appointmentArray = Appointment.modelsFromDictionaryArray(array: appointmentList)
        self.bAppointmentTableView.reloadData()
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }

    
    
    
    @IBAction func bBackBtnAppointmentVc(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! AppointmentsTableCell
      let appointment = appointmentArray[indexPath.row]
      cell.bNameLbl.text = appointment.artistService?.name
      cell.bAddressLbl.text = appointment.address
      if self.artistID != nil{
          cell.mArtistName.text = appointment.user?.name
      }else{
         cell.mArtistName.text = appointment.artist?.businessName
      }
    
     cell.mTimeLbl.text = appointment.time?.utcStringToLocalDateTimeForNotification
     
      if appointment.artist?.coverPic != nil{
        cell.bArtistImg.sd_setImage(with: URL.init(string:(appointment.artist?.coverPic!.httpsExtend)!), placeholderImage: #imageLiteral(resourceName: "bookartist2"))
      }
      
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailvc = storyboard?.instantiateViewController(withIdentifier: "AppointmentDetailVCID") as! AppointmentDetailVC
      let appointment = appointmentArray[indexPath.row]
      detailvc.appointment = appointment
      detailvc.artist = appointment.artist
      detailvc.isArtist = self.mArtistTriggerButton.isSelected
      detailvc.selectedService = appointment.artistService
      navigationController?.pushViewController(detailvc, animated: true)
    }
}
