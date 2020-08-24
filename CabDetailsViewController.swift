//
//  CabDetailsViewController.swift
//  Cabs
//
//  Created by Hemanth kumar  on 22/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit
import MBProgressHUD
class CabDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,userDataDelegate {

    let headerIdentifier = "ProfileHeader"
    let cellIdentifier = "ProfileCell"
    let footerIdentifier = "ProfileFooter"
    let images: [UIImage] = [#imageLiteral(resourceName: "KMS-1"), #imageLiteral(resourceName: "SEATER-1"), #imageLiteral(resourceName: "CARS"), #imageLiteral(resourceName: "FUEL-1"), #imageLiteral(resourceName: "AC-1"), #imageLiteral(resourceName: "TRANSMISSION-1")]
    var names = ["KMS-1","SEATER-1","CARS","FUEL-1","AC-1","TRANSMISSION-1"]

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var Footerview: UIView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    //for pop view
    var cabDetails:AvailableCab!
    var userInfo = UserInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var acLbl = "NON-AC"
        if cabDetails.additionalInfo!.airConditionInd{
            acLbl = "AC"
        }
       
        names = ["\(cabDetails.approxDistance)","\(cabDetails.seatingCapacity)",cabDetails.cabCategory,cabDetails.additionalInfo!.fuelType,acLbl,cabDetails.additionalInfo!.transmissionType]
        
        lblTotalPrice.text = "₹ " + "\(self.cabDetails.driverCharges + self.cabDetails.nightHalt + self.cabDetails.convenienceFee)"
        
           if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.sectionHeadersPinToVisibleBounds = false
                }
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                           layout.sectionFootersPinToVisibleBounds = false
                       }
                collectionView.backgroundColor = .white
                // register header
                collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
                
                // register cell
                collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
                
        //        register footer
                 collectionView?.register(ProfileFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifier)
                
                
                collectionView.contentInsetAdjustmentBehavior = .never
        //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            
            override var preferredStatusBarStyle: UIStatusBarStyle {
                return .default
            }
    
    @IBAction func btnBook(_ sender: Any) {
        
        
        let popOverVC = PopUpViewController(nibName: "PopUpViewController", bundle: nil)
                    popOverVC.delegate = self
//        self.navigationController?.pushViewController(popOverVC, animated: true)
                self.addChild(popOverVC)
              popOverVC.view.frame = self.view.frame
              self.view.addSubview(popOverVC.view)
              popOverVC.didMove(toParent: self)
          
          }
    
    func getUserData(userData: UserInfo) {
        self.userInfo = userData
          let params = [
              "Address": userData.address,
              "ApproxRoundTripDistance": self.cabDetails.approxDistance,
              "BasicRate": self.cabDetails.basicRate,
              "CancellationPolicy": self.cabDetails.cancellationPolicy,
              "City": "",
              "Conveniencefee": self.cabDetails.convenienceFee,
              "Days": self.cabDetails.days,
              "DestinationId": 113,
              "DestinationName": "Bangalore",
              "DriverCharges": self.cabDetails.driverCharges,
              "EmailId": userData.emailId,
              "ExtraHourRate": self.cabDetails.extraHourRate,
              "JourneyDate": "01-12-2020",
              "MinimumChargedDistance": self.cabDetails.minimumChargedDistance,
              "MobileNo": userData.phoneNo,
              "Name": userData.name,
              "NightHalt": self.cabDetails.nightHalt,
              "NoOfCars": "1",
              "NoofPassengers": self.cabDetails.vehicleID,
              "Operator": "",
              "OperatorId": "",
              "OperatorName": "",
              "PerKmRateCharge": self.cabDetails.perKM,
              "PerKmRateOneWayCharge": self.cabDetails.perKMRateOneWayCharge,
              "key": self.cabDetails.key,
              "PickUpAddress": userData.address,
              "PickUpTime": self.cabDetails.additionalInfo!.pickUpDateTime,
              "PostalCode": "",
              "Provider": self.cabDetails.provider,
              "SessionId": "vxpj0ccfqvg1dk2532zffrom",
              "SMSUsageCount": 0,
              "SourceId": 149,
              "SourceName": "Hyderabad",
              "State": "Telangana",
              "TotalFare": self.cabDetails.partnerFareDatails!.netFares,
              "TravelType": 1,
              "TripType": 1,
              "User": "",
              "UserType": 5,
              "VehicleName": self.cabDetails.name,
              "WaitingCharges": self.cabDetails.waitingCharges
            ] as [String : Any]
           //*** Call Block API & Book API in Sequence
         MBProgressHUD.showAdded(to: self.view, animated: true)
        let networkManager = NetworkManager()
        networkManager.blockCab(reqParams: params) { (response, error) in
            
            let blockData = Blockcab(dict: response)
           
            if blockData.bookingStatus == 1 {
                
                //*** Payment Method Should be called
                self.bookCabPostPayment(referenceNo: blockData.referenceNo)
            }
            else {
                 //*** blockData.message
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.presentAlertWithTitleAndMessage(title: "Cabs", message: blockData.message, options: ["Ok"]) { (option) in
                    }
                }
            }
        }
       }
    
    func bookCabPostPayment(referenceNo:String){
        //ReferenceNo
        let params = [
        "ReferenceNo": referenceNo]
        let networkManager = NetworkManager()
        networkManager.bookCab(reqParams: params) { (response, error) in
            let bookedData = BookCab(dict: response)
            
            if bookedData.bookingStatus == 3 {
                self.userInfo.referenceNo = bookedData.referenceNo
                        self.userInfo.type = bookedData.tripType
                        print(response)
                DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                let vc = BookingDetailsCabViewController(nibName: "BookingDetailsCabViewController", bundle: nil)
                vc.userInfo = self.userInfo
                self.navigationController?.pushViewController(vc, animated: true)
                }
            }
    else {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.presentAlertWithTitleAndMessage(title: "Cabs", message: bookedData.message, options: ["Ok"]) { (option) in
                  }
                }
            }
        }
    }
}
extension CabDetailsViewController {
    
      func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
                header.delegate = self
            
                if self.cabDetails.name == "Toyota Innova" {
                    header.profileImageView.image = UIImage(named: "toyoto_innova")
                } else if self.cabDetails.name == "Tempo Traveller (12 + 1 seater)" {
                    header.profileImageView.image = UIImage(named: "traveller")
                } else if self.cabDetails.name == "Toyota Camry or Equivalent" {
                    header.profileImageView.image = UIImage(named: "camry")
                }else if self.cabDetails.name == "Toyota Corolla or Equivalent" {
                    header.profileImageView.image = UIImage(named: "corolla")
                } else if self.cabDetails.name == "Toyota Etios or Equivalent" {
                    header.profileImageView.image = UIImage(named: "etios-car")
                } else if self.cabDetails.name == "Honda City or Equivalent" {
                    header.profileImageView.image = UIImage(named: "honda-city")
                } else if self.cabDetails.name == "Toyota Innova Cresta" {
                    header.profileImageView.image = UIImage(named: "cresta")
                } else {
                    header.profileImageView.image = UIImage(named: "cresta")
                }
            
                header.CompanyName.text  = self.cabDetails.name
              return header
        }
    else {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as! ProfileFooter
            footer.DriverChargesPriceLabel.text = "₹ " + "\(self.cabDetails.driverCharges)"
            footer.NightHaltPriceLabel.text = "₹ " + "\(self.cabDetails.nightHalt)"
            footer.lblRightConvienceFee.text = "₹ " + "\(self.cabDetails.convenienceFee)"
            footer.lblBasicFareprice.text = "₹ " + "\(self.cabDetails.basicRate)"
            footer.lblTotalFarePrice.text = "₹ " + "\(self.cabDetails.totalAmount)"
            footer.lblMinChargedHourPrice.text = "₹ " + "\(self.cabDetails.minimumChargedDistance)"
            footer.lblExtraHourRatePrice.text = "₹ " + "\(self.cabDetails.extraHourRate)"
            footer.lblCancelationPolicyPrice.text = "₹ " + "\(self.cabDetails.cancellationPolicy)"
            
            let attributedString = NSAttributedString(string: NSLocalizedString("TermsAndConditions", comment: ""), attributes:[
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0),
                NSAttributedString.Key.foregroundColor : UIColor.blue,
                NSAttributedString.Key.underlineStyle:1.0
            ])

            footer.btnTermsAndConditions.setAttributedTitle(attributedString, for: UIControl.State.normal)
            footer.btnTermsAndConditions.addTarget(self, action: #selector(popTermsAndConditions), for: UIControl.Event.touchUpInside)
//            footer.lblRightTermsAndConditions.text = self.cabDetails.termsConditions.html2String
             return footer
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           return CGSize(width: view.frame.width, height: 300)
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
       }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell

        cell.backgroundView?.frame = CGRect(x: 0, y: -5, width: cell.contentView.bounds.size.width-5, height: cell.contentView.bounds.size.height-10)
        cell.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        cell.layer.masksToBounds = false
        cell.cellImageView.frame = CGRect(x: 0, y: -5, width: cell.contentView.bounds.size.width-5, height: cell.contentView.bounds.size.height-25)
        cell.image = images[indexPath.row]
        cell.imgLabel.numberOfLines = 0
        cell.imgLabel.text = names[indexPath.row]
        cell.imgLabel.frame = CGRect(x: 15, y: cell.contentView.bounds.size.height-30, width: cell.contentView.bounds.size.width-20, height: 20)
        cell.CornerRadiousWithShadow(cornerRadus: 2)

        
        return cell
    }
  
    @objc func popTermsAndConditions(){
        print("Terms & Conditions.")
        let popVC = TermsAndConditionsViewController(nibName: "TermsAndConditionsViewController", bundle: nil)
        popVC.htmlString = cabDetails.termsConditions
        self.navigationController?.present(popVC, animated: true, completion: nil)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension CabDetailsViewController: UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3 - 80/3
        return CGSize(width: width, height: width)
    }
    
}
extension CabDetailsViewController: ProfileHeaderDelegate {
    func btnBackClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainBlue = UIColor.rgb(red: 249, green: 249, blue: 249)
}

extension UIView {

    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }

        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }

        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

