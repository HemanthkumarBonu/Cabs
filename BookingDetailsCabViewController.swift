//
//  BookingDetailsCabViewController.swift
//  Cabs
//
//  Created by Hemanth kumar  on 24/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit

class BookingDetailsCabViewController: UIViewController {
    
      @IBOutlet weak var lblFromCity: UILabel!
      @IBOutlet weak var lbltoCity: UILabel!
      @IBOutlet weak var lblstartDate: UILabel!
      @IBOutlet weak var lblCabType: UILabel!
      @IBOutlet weak var lblPickUpLocation: UILabel!
      @IBOutlet weak var lblDropLocation: UILabel!
      @IBOutlet weak var lblPassengerName: UILabel!
      @IBOutlet weak var lblSeatingcapacity: UILabel!
      @IBOutlet weak var lblBookingRefNo: UILabel!
      @IBOutlet weak var lblPickUpTime: UILabel!
      @IBOutlet weak var lblTotalFare: UILabel!
      @IBOutlet weak var btnCancellationPolicy: UIButton!

      var userInfo:UserInfo!
      var bookingDetails:CabDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                self.getBookingDetailsInfo()
    }

    @IBAction func CancellationPolicyClicked(_ sender: Any) {
    }
    
    
    
    @IBAction func btnCancelCabAccessed(_ sender: Any) {
         let vc = TripTypeViewController(nibName: "TripTypeViewController", bundle: nil)
                                     self.navigationController?.pushViewController(vc, animated: true)
    }
    
     func getBookingDetailsInfo() {
        let params = ["referenceNo":userInfo.referenceNo,"type":userInfo.type,"mobileno":userInfo.phoneNo,"EmailId":userInfo.emailId] as [String : Any] 
        
        let networkManager = NetworkManager()
        networkManager.getCabBookingDetails(reqParams: params, completion: { (response, error) in
            let _bookingDetails = CabDetails(dict: response)
            self.bookingDetails = _bookingDetails
            DispatchQueue.main.async {
                self.updateUI()
            }
        })
    }
    
    func updateUI(){
        self.lblFromCity.text = self.bookingDetails.sourceName
        self.lbltoCity.text = self.bookingDetails.destinationName
        self.lblstartDate.text = self.bookingDetails.journeyDate
        self.lblCabType.text = self.bookingDetails.vehicleName
        self.lblPickUpLocation.text = self.bookingDetails.pickUpLocation
        self.lblDropLocation.text = self.bookingDetails.dropLocation
        self.lblPassengerName.text = self.bookingDetails.name
        self.lblSeatingcapacity.text = self.bookingDetails.noofPassengers
        self.lblBookingRefNo.text = self.bookingDetails.bookingRefNo
        self.lblPickUpTime.text = self.bookingDetails.pickUpTime
        self.lblTotalFare.text = self.bookingDetails.totalFare
    }

}

