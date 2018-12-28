//
//  ArtistSpecificVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 07/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftLocation

class ArtistSpecificVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

  @IBOutlet weak var mCoverPic: UIImageView!
  @IBOutlet weak var mRangeLbl: UILabel!
  @IBOutlet weak var mAvailableIcon: UIImageView!
  @IBOutlet weak var mAvailableLbl: UILabel!
  @IBOutlet weak var mAvailablityTimeLbl: UILabel!
  @IBOutlet weak var mRatingImgView: UIImageView!
  @IBOutlet weak var mAddressLbl: UILabel!
  @IBOutlet weak var mHeaderLbl: UILabel!
  @IBOutlet weak var bArtistSpecificTableView: UITableView!
    @IBOutlet weak var bBookNowBtnOutl: UIButton!
    @IBOutlet weak var bCallArtistBtnOut: UIButton!
    @IBOutlet weak var bMessageArtistBtnOut: UIButton!
  var artistApi :ArtistAPI!
  var artist: Artist!
  var serviceArray: [Services]!
   var allServicelist: [String]!
  var inTime = ""
  var outTime = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
      artistApi = ArtistAPI.sharedInstance
      serviceArray = [Services]()
        self.bArtistSpecificTableView.delegate = self
        self.bArtistSpecificTableView.dataSource = self
        self.bBookNowBtnOutl.layer.cornerRadius = 6
       self.uiSetup()
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
  
  
  func uiSetup()  {
    self.getArtistServices()
    self.getCurrentLocation()
    self.title = artist.user?.name
    self.mHeaderLbl.text = artist.businessName
    self.mAddressLbl.text = artist.user?.location
    self.mRangeLbl.text = "\(artist.availbilityRange!) Km"
    let fromDate = artist.availbilityStart?.dateTimeToTodayTime().jsonStringToDate as! Date
    let tillDate = artist.availbilityTill?.dateTimeToTodayTime().jsonStringToDate as! Date
    
   if Date().checkTimeInBetween(date1: fromDate, date2: tillDate) == true{
      self.mAvailableLbl.text = "Available"
  
   }else{
     self.mAvailableLbl.text = "Not Available"
    }
    self.mAvailableIcon.image = UIImage(named:self.mAvailableLbl.text!)
    self.mAvailablityTimeLbl.text = "\(fromDate.dateToSmartTime) : \(tillDate.dateToSmartTime)"
    if artist.coverPic != nil{
      self.mCoverPic.sd_setImage(with: URL.init(string:artist.coverPic!.httpsExtend), placeholderImage: #imageLiteral(resourceName: "bookartist2"))
    }
 
 
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
        self.bArtistSpecificTableView.reloadData()
        self.allServicelist = [String]()
        for i in self.serviceArray{
          self.allServicelist.append(i.name!)
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
          
        }
        
      }) { err in
        print(err)
      }
    }, onFail: {(e, b) -> (Void) in
      print("")
      
    })
  }
    

    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func bBookNowBtnTapped(_ sender: UIButton) {
        let CreateAppointmentVC = storyboard?.instantiateViewController(withIdentifier: "CreateAppointmentVCId") as! CreateAppointmentVC
        CreateAppointmentVC.serviceArray = self.serviceArray
        CreateAppointmentVC.services = self.allServicelist
        CreateAppointmentVC.artist = self.artist
        self.navigationController?.pushViewController(CreateAppointmentVC, animated: true)
        
        
    }
    
  @IBAction func mCallActionBtn(_ sender: UIButton) {
    if self.artist.phone != nil {
      self.callNumber(phoneNumber: "\(self.artist.phone!)")
    }
    
  }
  
  @IBAction func mSendMessageAction(_ sender: UIButton) {
    
  }
  
  private func callNumber(phoneNumber:String) {
    
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
      
      let application:UIApplication = UIApplication.shared
      if (application.canOpenURL(phoneCallURL)) {
        application.open(phoneCallURL, options: [:], completionHandler: nil)
      }
    }
  }
  
    
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
