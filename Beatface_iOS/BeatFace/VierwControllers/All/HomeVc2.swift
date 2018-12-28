//
//  HomeVc2.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 19/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit

class HomeVc2: UIViewController, UITableViewDelegate , UITableViewDataSource {
   
    @IBOutlet weak var bHome2Table: UITableView!
    
    let bHome2ImgArray = ["home1", "home2", "home3artistappointments" ,"home4" , "home5"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bHome2Table.delegate = self
        self.bHome2Table.dataSource = self}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  bHome2ImgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Home2Cell", for: indexPath) as! HomeTableVCell
        cell.gHome2CellImg.image = UIImage (named: bHome2ImgArray[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vcbfspotlight = storyboard?.instantiateViewController(withIdentifier: "BfSpotlightId") as! BfSpotlightVc
            self.navigationController?.pushViewController(vcbfspotlight, animated: true)
            return
        }
        else if indexPath.row == 2 {
            let yourbfappointmentsvc = storyboard?.instantiateViewController(withIdentifier: "YourBfAppointmentsId") as! YourBfAppointmentsVc
            self.navigationController?.pushViewController(yourbfappointmentsvc, animated: true)
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
