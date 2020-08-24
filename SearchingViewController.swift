//
//  SearchingViewController.swift
//  Cabs
//
//  Created by Hemanth kumar  on 14/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit
import DatePickerDialog
import MBProgressHUD
class SearchingViewController: UIViewController, UITextFieldDelegate, CitySelectedDelegate{
 
    @IBOutlet weak var viewOutstation: UIView!
    @IBOutlet weak var viewFromTo: UIView!
    @IBOutlet weak var segTripType: UISegmentedControl!
    @IBOutlet weak var txtInputFrom: UITextField!
    @IBOutlet weak var imgFromCity: UIImageView!
    @IBOutlet weak var txtInputTo: UITextField!
    @IBOutlet weak var btnSwap: UIButton!
    @IBOutlet weak var viewSelectDateAndtime: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwOutstationToDate: UIView!
    //    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var downArrow: UIImageView!
    @IBOutlet weak var vwDate: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var lblOutStationEndDate: UILabel!
    @IBOutlet weak var lblOutStationEndDateMonth: UILabel!
    @IBOutlet weak var lblOutStationEndDateDay: UILabel!
    @IBOutlet weak var txtOutstationPickupTime: UITextField!
    
    //    For Local
    @IBOutlet weak var viewLocal: UIView!
    @IBOutlet weak var viewSelectLocation: UIView!
    @IBOutlet weak var txtScity: UITextField!
    @IBOutlet weak var viewSelectDateTime: UIView!
    @IBOutlet weak var segHrsPerDay: UISegmentedControl!
    @IBOutlet weak var backBtnAccessed: UIButton!
    @IBOutlet weak var vwLocalDate: UIView!
    @IBOutlet weak var lblLocalDate: UILabel!
    @IBOutlet weak var lblLocalMonth: UILabel!
    @IBOutlet weak var lblLocalDay: UILabel!
    @IBOutlet weak var txtLocalPickUpTime: UITextField!
    
//    For Transfer
    @IBOutlet weak var viewTransfer: UIView!
    @IBOutlet weak var segSelectLocation: UISegmentedControl!
    @IBOutlet weak var viewAlocation: UIView!
    @IBOutlet weak var btnBackTranfser: UIButton!
    @IBOutlet weak var txtSelectCity: UITextField!
    @IBOutlet weak var txtPickupLocation: UITextField!
    @IBOutlet weak var txtDropLocation: UITextField!
    @IBOutlet weak var viewSelectDateandTime: UIView!
    @IBOutlet weak var lblTransferDate: UILabel!
    @IBOutlet weak var lblTransferMonth: UILabel!
    @IBOutlet weak var lblTransferDay: UILabel!
    @IBOutlet weak var txtTransferPickupTime: UITextField!
    
    //For Timepicker
       
    @IBOutlet weak var timePickerContainerView: UIView!
    
      
    var outStationStartDate = ""
    var outStationEndDate = ""
    var localDate = ""
    var transferDate = ""
    var masterTripType = 1
    var selectedTF:UITextField!
    var selectedTF1:UITextField!
    var sourcesArray:[SourceCity] = Array()
    var transferType = 0
    var selectedCity:SourceCity!
    var selectedDestination:SourceCity!
    

    
 override func viewDidLoad() {
    super.viewDidLoad()

        let date = Date()
        let format = DateFormatter()
        let format1 = DateFormatter()
           format.dateFormat = "dd MMM yyyy"
           format1.dateFormat = "dd-MM-yyyy"
      
        self.outStationStartDate = format1.string(from: date)
        self.outStationEndDate = format1.string(from: date)
        self.localDate = format1.string(from: date)
        self.transferDate = format1.string(from: date)
        let formattedTodayDate = format.string(from: date)
        let currentDateArray = formattedTodayDate.components(separatedBy: " ")
        dateLbl.text = currentDateArray[0]
        monthLbl.text = currentDateArray[1].uppercased()
        dayLbl.text = date.dayofTheWeek
        // for Local
        lblLocalDate.text = currentDateArray[0]
        lblLocalMonth.text = currentDateArray[1].uppercased()
        lblLocalDay.text = date.dayofTheWeek
        //For Transfer
        lblTransferDate.text = currentDateArray[0]
        lblTransferMonth.text = currentDateArray[1].uppercased()
        lblTransferDay.text = date.dayofTheWeek
        
        let tomorrowDate = Calendar.current.date(byAdding: .day, value: +1, to: date)
        let formattedTomorrowDate = format.string(from: tomorrowDate!)
        let TomorrowDateArray = formattedTomorrowDate.components(separatedBy: " ")
         lblOutStationEndDate.text = TomorrowDateArray[0]
         lblOutStationEndDateMonth.text = TomorrowDateArray[1].uppercased()
         lblOutStationEndDateDay.text = date.dayofTheWeek
        
        //For Timepicker
      
        setupview(segment: segTripType)
        setupview(segment: segHrsPerDay)
        setupview(segment: segSelectLocation)
        
        self.addView(tripType: self.masterTripType)
        
        self.Shadow(view: viewFromTo)
        self.Shadow(view: viewSelectDateAndtime)
        self.Shadow(view: viewSelectLocation)
        self.Shadow(view: viewSelectDateTime)
        self.Shadow(view: viewAlocation)
        self.Shadow(view: viewSelectDateandTime)
        self.shadow(textField: txtScity)
           

        let networkManager = NetworkManager()
               networkManager.getSources { (sources, error) in
                self.sourcesArray.append(contentsOf: sources!)
               }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.endEditing(true)
               self.selectedTF = textField
       //        textField.resignFirstResponder()
               let vc = CitySearchControllerViewController(nibName: "CitySearchControllerViewController", bundle: nil)
               vc.delegate = self
               vc.tripType = self.masterTripType
               vc.sourcesArray = self.sourcesArray
               if self.masterTripType == 3 {
                   vc.transFerType = self.transferType
                   vc.fieldTag = self.selectedTF.tag
                   if self.selectedTF.tag != 201{
                       if self.selectedCity == nil {
                           self.presentAlertWithTitleAndMessage(title: "Cabs", message: "Please select City before selecting pickup or drop locations.", options: ["Ok"]){ (option) in
                               
                           }
                           return
                       }
                       vc.selectedCityID = self.selectedCity.id
                       let obj = self.sourcesArray.filter{($0.id == self.selectedCity.id)}
                       vc.airPortsArray = obj[0].airports
                       vc.hotelsArray = obj[0].hotels
                       vc.railwayStations = obj[0].railwayStations
                   }
               }
               self.present(vc, animated: true, completion: nil)
           }

            func selectedCity(city: SourceCity) {
                           self.selectedTF.text = city.name
                       if selectedTF == txtInputTo {
                           self.selectedDestination = city
                       }
                       else{
                           self.selectedCity = city
                       }
                   }
       
       func selectedData(data: String) {
           if self.selectedTF.tag == 202 || self.selectedTF.tag == 203{
               self.selectedTF.text = data
           }

       }

    
    func setupview(segment:UISegmentedControl) {
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
    }
    func Shadow(view:UIView) {
        view.layer.shadowColor =  UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    func shadow(textField:UITextField){
         textField.layer.shadowColor =  UIColor.lightGray.cgColor
         textField.layer.shadowOpacity = 1
         textField.layer.shadowOffset = .zero
         textField.layer.shadowRadius = 0.5
         textField.layer.shouldRasterize = true
         textField.layer.rasterizationScale = UIScreen.main.scale
    }
    func addView(tripType: Int){
        switch tripType {
        case 1:
            self.view.addSubview(viewOutstation)
            break
        case 2:
            self.view.addSubview(viewLocal)
            break
        case 3:
            self.view.addSubview(viewTransfer)
            break
        default:
            self.view.addSubview(viewOutstation)
            break
        }
    }
    func cancelDatePicker(){
     //cancel button dismiss datepicker dialog
      self.view.endEditing(true)
    }
    
   //  Swap in Outstation

    @IBAction func btnSwap_Clicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.btnSwap.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
        }) { (true) in
            self.btnSwap.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi * 2)))
        }
        UIView.beginAnimations(nil, context: nil)
        (txtInputFrom.frame.origin, txtInputTo.frame.origin) = (txtInputTo.frame.origin, txtInputFrom.frame.origin)
        UIView.commitAnimations()
    }

    @IBAction func segTripTypeAccessed(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            vwOutstationToDate.isHidden = true
            downArrow.isHidden = true
        }
        else{
            vwOutstationToDate.isHidden = false
            downArrow.isHidden = false
        }
    }
    
    @IBAction func segTransfertype(_ sender: UISegmentedControl){
        
        self.transferType = sender.selectedSegmentIndex
        self.txtPickupLocation.text = ""
        self.txtDropLocation.text = ""
    }
    
    @IBAction func outStationStartDateAccessed(_ sender: Any) {
        DatePickerDialog().show("Start Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:Date(), datePickerMode: .date) {
              (date) -> Void in
              if let dt = date {
                let format = DateFormatter()
                let format1 = DateFormatter()
                format.dateFormat = "dd MMM yyyy"
                format1.dateFormat = "dd-MM-yyyy"
                let formattedTodayDate = format.string(from: dt)
                let currentDateArray = formattedTodayDate.components(separatedBy: " ")
                self.outStationStartDate = format1.string(from: dt)
                self.dateLbl.text = currentDateArray[0]
                self.monthLbl.text = currentDateArray[1].uppercased()
                self.dayLbl.text = dt.dayofTheWeek


            }
          }
      }
    
    @IBAction func OutStationToBtnAccessed(_ sender: Any) {
        DatePickerDialog().show("End Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:Date(), datePickerMode: .date) {
                    (date) -> Void in
                    if let dt = date {
                          let format = DateFormatter()
                              format.dateFormat = "dd MMM yyyy"
                          let format1 = DateFormatter()
                          format1.dateFormat = "dd-MM-yyyy"
                          let formattedTomorrowDate = format.string(from: dt)
                          let TomorrowDateArray = formattedTomorrowDate.components(separatedBy: " ")
                      self.outStationEndDate = format1.string(from: dt)
                      self.lblOutStationEndDate.text = TomorrowDateArray[0]
                      self.lblOutStationEndDateMonth.text = TomorrowDateArray[1].uppercased()
                      self.lblOutStationEndDateDay.text = dt.dayofTheWeek

                  }
                }
        
    }
    @IBAction func LocalDateBtnAccessed(_ sender: Any) {
        DatePickerDialog().show("Start Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:Date(), datePickerMode: .date) {
                    (date) -> Void in
                    if let dt = date {
                          let format = DateFormatter()
                              format.dateFormat = "dd MMM yyyy"
                        let format1 = DateFormatter()
                            format1.dateFormat = "dd-MM-yyyy"
                          let formattedTodayDate = format.string(from: dt)
                          let currentDateArray = formattedTodayDate.components(separatedBy: " ")
                         self.localDate = format1.string(from: dt)
                      self.lblLocalDate.text = currentDateArray[0]
                      self.lblLocalMonth.text = currentDateArray[1].uppercased()
                      self.lblLocalDay.text = dt.dayofTheWeek

                  }
                }
    }
    @IBAction func TransferDatebtnAccessed(_ sender: Any) {
        DatePickerDialog().show("Start Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:Date(), datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                  let format = DateFormatter()
                      format.dateFormat = "dd MMM yyyy"
                let format1 = DateFormatter()
                    format1.dateFormat = "dd-MM-yyyy"
                  let formattedTodayDate = format.string(from: dt)
                  let currentDateArray = formattedTodayDate.components(separatedBy: " ")
                self.transferDate = format1.string(from: dt)
              self.lblTransferDate.text = currentDateArray[0]
              self.lblTransferMonth.text = currentDateArray[1].uppercased()
              self.lblTransferDay.text = dt.dayofTheWeek

          }
        }
    }
    @IBAction func OutStationTimeAccessed(_ sender: Any) {
      
        
        DatePickerDialog().show("Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel",minimumTimeInterval:5, datePickerMode: .time) {
              (date) -> Void in
             if let dt = date {
               let dateFormatter = DateFormatter()
                     // change to a readable time format and change to local time zone
                    dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
                    dateFormatter.timeZone = NSTimeZone.local
            let timeStamp = dateFormatter.string(from: dt)
            let timeString = timeStamp.components(separatedBy: " - ")[1]
                    print(timeString)
             dateFormatter.timeZone = TimeZone.current
            self.txtOutstationPickupTime.text = timeString
//            self.cancelDatePicker()
            if date != nil {

            }
          }
        }
    }
    
    @IBAction func btnLocalTimeAccessed(_ sender: Any) {
          DatePickerDialog().show("Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel",minimumTimeInterval:5, datePickerMode: .time) {
                      (date) -> Void in
            if let dt = date {
                       let dateFormatter = DateFormatter()
                             // change to a readable time format and change to local time zone
                             dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
                             dateFormatter.timeZone = NSTimeZone.local
                             let timeStamp = dateFormatter.string(from: dt)
                            let timeString = timeStamp.components(separatedBy: " - ")[1]
                            print(timeString)
                    self.txtLocalPickUpTime.text = timeString

                    if date != nil {

                    }
                  }
        }
    }
     @IBAction func btnTransferTimeAccessed(_ sender: Any) {
        DatePickerDialog().show("Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel",minimumTimeInterval:5, datePickerMode: .time) {
                            (date) -> Void in
            if let dt = date {
                             let dateFormatter = DateFormatter()
                                   // change to a readable time format and change to local time zone
                                   dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
                                   dateFormatter.timeZone = NSTimeZone.local
                                   let timeStamp = dateFormatter.string(from: dt)
                                  let timeString = timeStamp.components(separatedBy: " - ")[1]
                                  print(timeString)
                          self.txtTransferPickupTime.text = timeString

//                          if date != nil {
//
//                          }
                        }
        }
    }
    @IBAction func btnBackAccessed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnOutStationSearch(_ sender: Any) {
        // OneWay no returnDate & Round with Return Date
        // oneway triptype 1 &  roundtrip triptype 2

        
        let params = ["sourceId":self.selectedCity.id,"destinationId":self.selectedDestination.id,"journeyDate":self.outStationStartDate,"operatorName":"","pickUpTime": self.txtOutstationPickupTime.text!,"pickuplocation":"","droplocation":"","noOfDays":"1","travelType":"1","tripType":"1","sessionId":"vxpj0ccfqvg1dk2532zffrom","userType":"5","user":"","returnDate":self.outStationEndDate] as [String : Any]
        
      if self.txtInputFrom.text!.isEmpty || self.txtInputTo.text!.isEmpty || self.txtOutstationPickupTime.text!.isEmpty {
       self.presentAlertWithTitleAndMessage(title: "Cabs", message: "Please select all the options to continue your search.", options: ["Ok"]) { (option) in
        
    }
    return
}
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let networkManager = NetworkManager()
            networkManager.getCabs(reqParams: params) { (response, error) in
                print("Available response")
               
                let cabResponse = AvailableCabsResponse(dict: response)
                
                print(cabResponse.availableCabs.count)
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let vc = AvailbleCabsViewController(nibName: "AvailbleCabsViewController", bundle: nil)
                    vc.availableCabs = cabResponse.availableCabs
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
       }
    
    //    for local
    @IBAction func btnLocalSearch(_ sender: Any) {
        //local triptype 4,8,12,24 vl change according selection
        var _tripType = "6"
        
        switch self.segHrsPerDay.selectedSegmentIndex {
        case  0:
            _tripType = "4"
            break
        case  1:
            _tripType = "8"
            break
        case  2:
            _tripType = "12"
            break
        case  3:
            _tripType = "24"
            break
        default:
            _tripType = "8"
            break
        }
        
        if self.txtScity.text!.isEmpty {
            self.presentAlertWithTitleAndMessage(title: "Cabs", message: "Please select all the options to continue your search.", options: ["Ok"]) { (option) in
                
            }
            return
        }

        
        let params = ["sourceId":self.selectedCity.id,"destinationId":"0","journeyDate":self.localDate,"operatorName":"","pickUpTime":self.txtLocalPickUpTime.text!,"pickuplocation":"","droplocation":"","noOfDays":"1","travelType":"2","tripType":_tripType,"sessionId":"vxpj0ccfqvg1dk2532zffrom","userType":"5","user":""] as [String : Any]
        let networkManager = NetworkManager()
        networkManager.getCabs(reqParams: params) { (response, error) in
            print("Available response")
           
            let cabResponse = AvailableCabsResponse(dict: response)
            
            print(cabResponse.availableCabs.count)
            DispatchQueue.main.async {
                let vc = AvailbleCabsViewController(nibName: "AvailbleCabsViewController", bundle: nil)
                vc.availableCabs = cabResponse.availableCabs
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    @IBAction func btnTransferSearch(_ sender: Any) {
        
        if self.txtPickupLocation.text!.isEmpty || self.txtDropLocation.text!.isEmpty || self.txtSelectCity.text!.isEmpty {
            self.presentAlertWithTitleAndMessage(title: "Cabs", message: "Please select all the options to continue your search.", options: ["Ok"]) { (option) in
                
            }
            return
        }
        
        var _tripType = "6"
        switch self.segSelectLocation.selectedSegmentIndex {
        case 0:
            _tripType = "6"
            break
        case 1:
            _tripType = "7"
            break
        case 2:
            _tripType = "8"
            break
        default:
            _tripType = "6"
            break
        }
        
        let params = ["sourceId":self.selectedCity.id,"destinationId":"0","journeyDate":self.transferDate,"operatorName":"","pickUpTime":self.txtTransferPickupTime.text!,"pickuplocation":self.txtPickupLocation.text!,"droplocation":self.txtDropLocation.text!,"noOfDays":"1","travelType":"3","tripType":_tripType,"sessionId":"jg4afmeswmxalpqzbg2gjmhx","userType":"5","user":""] as [String : Any]
        let networkManager = NetworkManager()
               networkManager.getCabs(reqParams: params) { (response, error) in
                   print("Available response")
                  
                   let cabResponse = AvailableCabsResponse(dict: response)
                   
                   print(cabResponse.availableCabs.count)
                   DispatchQueue.main.async {
                let vc = AvailbleCabsViewController(nibName: "AvailbleCabsViewController", bundle: nil)
                       vc.availableCabs = cabResponse.availableCabs
                       self.navigationController?.pushViewController(vc, animated: true)
                   }
               }
    }
 
    @IBAction func backBtnAcccessed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackTransferAccessed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension Date {

    var dayofTheWeek: String {
         let dayNumber = Calendar.current.component(.weekday, from: self)
         // day number starts from 1 but array count from 0
         return daysOfTheWeek[dayNumber - 1]
    }

    private var daysOfTheWeek: [String] {
         return  ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    }
 }
