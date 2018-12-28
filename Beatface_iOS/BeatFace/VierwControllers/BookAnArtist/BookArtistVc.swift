//
//  BookArtistVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 15/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class BookArtistVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
  @IBOutlet weak var mSearchTypeBtn: UIButton!
  @IBOutlet weak var mEmptyList: UILabel!
  @IBOutlet weak var mSortByBtn: UIButton!
  @IBOutlet weak var mSearchBtn: UIButton!
  @IBOutlet weak var mSearchTextField: UITextField!
  @IBOutlet weak var gBookArtistTableVIew: UITableView!
    
   let bBookArtistImgArray = ["bookartist1", "bookartist2", "bookartist3", "bookartist4"]
   var bArtistNames = ["Mr Kalien Brown", "Mrs Livina Smith", "Jenqline Frnes", "Liily Sam"]
   var bArtistAddress = ["Crete,NE,USA","Crete,NE,USA","Crete,NE,USA","Crete,NE,USA"]
   let bAvail = [true,true,false,true]
    
    var artistDetailsArray = [[String:Any]] ()
  private var artistApi : ArtistAPI!
   private var artistArray : [Artist]!
   private var searchString: String = ""
  var allServicelist: [String]!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
      artistArray = []
      self.artistApi = ArtistAPI.sharedInstance
        self.gBookArtistTableVIew.delegate = self
        self.mSearchTextField.delegate = self
        self.gBookArtistTableVIew.dataSource = self
        let imgTitle = UIImage(named: "titleBookArtist")
        navigationItem.titleView = UIImageView(image: imgTitle)
      self.mSortByBtn.addTarget(self, action:#selector(BookArtistVc.handleSortBy(sender:)), for: .touchUpInside)
      VCHelper().createRoundButtonWithBoder(btn: self.mSortByBtn, boderWidth: 1, boderColor: UIColor.BaseTint().cgColor, cornerRadius: 10)
    }
  
  @objc func handleSortBy(sender: UIButton){
   self.getSortingOptions()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.mEmptyList.isHidden = true
    self.getAllArtist()
    DispatchQueue.global(qos: .background).async {
      self.getAllServices()
      
      DispatchQueue.main.async {
        print("This is run on the main queue, after the previous code in outer block")
      }
    }
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
  
  
  func getSortingOptions() {
    self.createPopUpForSelection(title: "Sort By", ValueArray: ["Rating","Near by","All"], view: self.mSortByBtn, callback: { (value, index) in
    
      self.mSortByBtn.setTitle(value, for: .normal)
    })
  }
  
  
  @IBAction func mSearchTypeBtn(_ sender: UIButton) {
    self.mSearchTypeBtn.isSelected = !self.mSearchTypeBtn.isSelected
    self.mSearchTypeBtn.setTitleColor(UIColor.lightGray, for: .normal)
    self.mSearchTypeBtn.setTitleColor(UIColor.lightGray, for: .selected)
    self.mSearchTextField.text = ""
  }
  
  func getAllArtist(searchString:String = "",pageNumber:Int = 1) {
    artistApi.getAllArtist(name: searchString,pageNo: pageNumber) { (data, error) in
      if data[APIConstants.isSuccess.rawValue] as! Bool == true {
        let artistList = data[APIConstants.items.rawValue] as! NSArray
        
        if artistList.count > 0 {
          self.mEmptyList.isHidden = true
        }else{
          self.mEmptyList.isHidden = false
        }
        self.artistArray = Artist.modelsFromDictionaryArray(array: artistList)
        self.gBookArtistTableVIew.reloadData()
      }
      else{
        print("Getting Error")
        
      }
      
    }
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
  
  func getServiceList() {
    var stringArry = [String]()
    if self.allServicelist != nil{
      stringArry = self.allServicelist!
    }else{
      stringArry = ["Nail Art","Pedicure","Menicure","Hair Wash","Spa","Hair Smoothening"]
    }
    self.createPopUpForSelection(title: "Select Service", ValueArray: stringArry, view: self.mSearchTextField, callback: { (value, index) in
      self.mSearchTextField.text = value
    })
  }
  
  @IBAction func mSearchBtnAction(_ sender: UIButton) {
    if self.mSearchTypeBtn.isSelected == true{
       self.getAllArtist(searchString:"&serviceName=" + self.mSearchTextField.text!)
    }else{
       self.getAllArtist(searchString:self.mSearchTextField.text!)
    }
   
    
  }
  
    @IBAction func mBackBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let artist = artistArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookartistcell", for: indexPath) as! BookArtistTableCell
      if artist.coverPic != nil{
        cell.bArtistBookImg.sd_setImage(with: URL.init(string:artist.coverPic!.httpsExtend), placeholderImage: #imageLiteral(resourceName: "bookartist2"))
      }
      
        cell.bArtistNameLbl.text = artist.businessName
        cell.bArtistAddressLbl.text = artist.user?.location
      let fromDate = artist.availbilityStart?.dateTimeToTodayTime().jsonStringToDate as! Date
      let tillDate = artist.availbilityTill?.dateTimeToTodayTime().jsonStringToDate as! Date
      
      if Date().checkTimeInBetween(date1: fromDate, date2: tillDate) == true{
        cell.bAvailabilityLbl.text = "Available"
      }else{
        cell.bAvailabilityLbl.text = "Not Available"
      }
        
        cell.bBookAnArtistCellView.layer.cornerRadius = 4
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artistspecificvc = storyboard?.instantiateViewController(withIdentifier: "ArtistSpecificId") as! ArtistSpecificVc
      artistspecificvc.artist = artistArray[indexPath.row]
        self.navigationController?.pushViewController(artistspecificvc, animated: true)
      
    }
}

extension BookArtistVc: UITextFieldDelegate{
  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.resignFirstResponder()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.mSearchBtn.sendActions(for: .touchUpInside)
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    textField.keyboardType = .emailAddress
    textField.returnKeyType = .done
    
    switch textField {
    
    case self.mSearchTextField:
      if self.mSearchTypeBtn.isSelected == true{
        textField.resignFirstResponder()
        
        self.getServiceList()
        return false
      }
      

    default:
      print("abc")
    }

    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }

    return true
  }
  
}

