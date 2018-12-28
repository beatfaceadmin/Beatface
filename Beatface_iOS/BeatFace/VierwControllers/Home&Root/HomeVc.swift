//
//  HomeVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 10/01/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree


class HomeVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bHomeTableView: UITableView!
     private var userAPI : UserAPI!
       var gHometableImg = ["home1" ,"home2" ,"home3" ,"home4" ,"home5"]
    
       var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userAPI = UserAPI.sharedInstance
        self.bHomeTableView?.delegate = self
        self.bHomeTableView?.dataSource =  self
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.tintColor = UIColor.white
        bHomeTableView.addSubview(refresher)
        self.bHomeTableView.reloadData()
        refresher.endRefreshing()
       
    
    }
  
  
  override func viewWillAppear(_ animated: Bool) {
    DispatchQueue.global(qos: .background).async {
      self.getMyProfile()
      
      DispatchQueue.main.async {
        print("This is run on the main queue, after the previous code in outer block")
      }
    }
  }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  
  
  func getMyProfile() {
     let id = Constants.kUserDefaults.string(forKey: appConstants.id)
    userAPI.getUserByID(Id: id!) { (data, error) in
      if data[APIConstants.isSuccess.rawValue] as! Bool == true {
        let profileData = data[APIConstants.data.rawValue] as! NSDictionary
        let artistStatus = profileData.value(forKey: appConstants.artistStatus) as! String
        if artistStatus == "approved"{
          if let artistID = profileData.value(forKeyPath: "artist.id") as? Int {
            Constants.kUserDefaults.set(artistID, forKey: appConstants.artistID)
          }
        }
        Constants.kUserDefaults.set(artistStatus, forKey: appConstants.artistStatus)
        let dataProfile = NSKeyedArchiver.archivedData(withRootObject: profileData)
        Constants.kUserDefaults.set(dataProfile, forKey: appConstants.profile)
        
      }
      else{
        print("Getting Error")
        
      }
      
    }
  }
  
  
  
  
  
  

    
    
    @IBAction func bProfileNavBtn(_ sender: UIBarButtonItem) {
     
        let bProfilevc = storyboard?.instantiateViewController(withIdentifier: "ProfileId") as! ProfileVc
        self.navigationController?.pushViewController(bProfilevc, animated: true)
        }
    
    @IBAction func bMyAppointmentsBtn(_ sender: UIBarButtonItem) {
        let AppointmentVc = storyboard?.instantiateViewController(withIdentifier: "AppointmentsId") as! AppointmentsVC
        self.navigationController?.pushViewController(AppointmentVc, animated: true)
    
    }
  
  
  
    
    
   
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gHometableImg.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! HomeTableVCell
        cell.gHomeCellImg.image = UIImage (named: gHometableImg[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vcbfspotlight = storyboard?.instantiateViewController(withIdentifier: "BfSpotlightId") as! BfSpotlightVc
            self.navigationController?.pushViewController(vcbfspotlight, animated: true)
            return
            }
        else if indexPath.row == 2 {
            let vcbeabfartist = storyboard?.instantiateViewController(withIdentifier: "ArtistOnboarding1ID") as! ArtistOnboarding1
            self.navigationController?.pushViewController(vcbeabfartist, animated: true)
            return
        }
            
      
        else if indexPath.row == 3 {
            let vcproductofthemonth = storyboard?.instantiateViewController(withIdentifier: "ProductOfTheMonthId") as! ProductOfTheMonthVc
            self.navigationController?.pushViewController(vcproductofthemonth, animated: true)
            return
        }
    else if indexPath.row == 4 {
            let vcaboutbf = storyboard?.instantiateViewController(withIdentifier: "AboutBfId") as! AboutBfVc
            self.navigationController?.pushViewController(vcaboutbf, animated: true)
            return
            
        }
        
    let bookartistvc = storyboard?.instantiateViewController(withIdentifier: "BookArtistId") as! BookArtistVc
            self.navigationController?.pushViewController(bookartistvc, animated: true)
    }
        
        
}




    
    


