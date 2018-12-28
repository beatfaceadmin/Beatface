//
//  YourBfAppointmentsVc.swift
//  BeatFace
//
//  Created by Gurpreet Gulati on 06/02/18.
//  Copyright © 2018 Gurpreet Gulati. All rights reserved.
//

import UIKit
import CVCalendar

class YourBfAppointmentsVc: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var bYourBfAppointmentsTbl: UITableView!
    @IBOutlet weak var bCalendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var bCalendarView: CVCalendarView!
   private var artistApi : ArtistAPI!
   private var artistArray : [Artist]!
    
    
    var bNames2 = ["Jasmine Daddario", "Romanoff O Clark", "Lucita Greek", "Jassica Bristania"]
    var bAddress2 = ["707 17th Street, Denver, Colorado, United States", "707 17th Street, Denver, Colorado, United States", "707 17th Street, Denver, Colorado, United States", "707 17th Street, Denver, Colorado, United States"]
    var bArtistImages2 = ["profileimage", "1portrait" , "2portrait", "3portrait"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgTitle = UIImage(named: "titleAppointments")
        navigationItem.titleView = UIImageView(image: imgTitle)
        self.bYourBfAppointmentsTbl.delegate = self
        self.bYourBfAppointmentsTbl.dataSource = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bNames2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourBfAppointmentsCell", for: indexPath) as! AppointmentsTableCell
        cell.bNameLabel2.text = bNames2[indexPath.row]
        cell.bAddressLbl2.text = bAddress2[indexPath.row]
        cell.bArtistImg2.image = UIImage(named:bArtistImages2[indexPath.row])
       
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
}
