//
//  ProfileFooter.swift
//  Cabs
//
//  Created by Hemanth kumar  on 22/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit

class ProfileFooter: UICollectionReusableView {
    
    let DriverChargesPriceLabel: UILabel = {
             let label = UILabel()
             label.textAlignment = .left
             label.text = ""
             label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        label.textColor =  UIColor.black
             return label
         }()
    let NightHaltPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        label.textColor = UIColor.black
        return label
    }()
    let AdditionaLbl: UILabel = {
             let label = UILabel()
             label.textAlignment = .left
             label.text = "Additional Details :"
             label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
             label.textColor =  UIColor.black
             return label
         }()
    let DriverLbl: UILabel = {
                let label = UILabel()
                label.textAlignment = .left
                label.text = "Driver Charges :"
                label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                label.textColor = UIColor.black
                return label
            }()
    let NightHaltLbl: UILabel = {
                let label = UILabel()
                label.textAlignment = .left
                label.text = "NightHalt Charges :"
                label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                label.textColor =  UIColor.black
                return label
            }()
    let ConvienceFeeLbl: UILabel = {
                   let label = UILabel()
                   label.textAlignment = .left
                   label.text = "Convience Fee :"
                   label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                   label.textColor =  UIColor.black
                   return label
               }()
    let lblRightConvienceFee: UILabel = {
         let label = UILabel()
         label.textAlignment = .left
         label.text = ""
         label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
         label.textColor =  UIColor.black
         return label
     }()
    
    let btnTermsAndConditions: UIButton = {
                      let button = UIButton()
                      button.contentHorizontalAlignment = .left
//                      button.setTitle("TermsAndConditions", for: .normal)
//                      button.titleLabel?.font =  UIFont(name: "regular", size: 18)
                      button.setTitleColor(UIColor.blue, for: .normal)

                      return button
                  }()
    let lblBasicFare: UILabel = {
               let label = UILabel()
               label.textAlignment = .left
               label.text = "BasicFare :"
               label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
               label.numberOfLines = 0
               label.textColor =  UIColor.black
               return label
           }()
    let lblBasicFareprice: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
        label.numberOfLines = 0
        label.textColor =  UIColor.black
        return label
    }()
    let lblTotalFare: UILabel = {
                  let label = UILabel()
                  label.textAlignment = .left
                  label.text = "TotalFare :"
                  label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                  label.numberOfLines = 0
                  label.textColor =  UIColor.black
                  return label
              }()
    let lblTotalFarePrice: UILabel = {
           let label = UILabel()
           label.textAlignment = .left
           label.text = ""
           label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
           label.numberOfLines = 0
           label.textColor =  UIColor.black
           return label
       }()
    let lblMinChargedHour: UILabel = {
                     let label = UILabel()
                     label.textAlignment = .left
                     label.text = "Minimum Charged Hour :"
                     label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                     label.numberOfLines = 0
                     label.textColor =  UIColor.black
                     return label
                 }()
    let lblMinChargedHourPrice: UILabel = {
             let label = UILabel()
             label.textAlignment = .left
             label.text = ""
             label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
             label.numberOfLines = 0
             label.textColor =  UIColor.black
             return label
         }()
   
    let lblExtraHourRate: UILabel = {
                        let label = UILabel()
                        label.textAlignment = .left
                        label.text = "Extra Hour Rate :"
                        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                        label.numberOfLines = 0
                        label.textColor =  UIColor.black
                        return label
                    }()
    let lblExtraHourRatePrice: UILabel = {
                   let label = UILabel()
                   label.textAlignment = .left
                   label.text = ""
                   label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
                   label.numberOfLines = 0
                   label.textColor =  UIColor.black
                   return label
               }()
    let lblCancelationPolicy: UILabel = {
                           let label = UILabel()
                           label.textAlignment = .left
                           label.text = "Cancelation Policy :"
                           label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
                           label.numberOfLines = 0
                           label.textColor =  UIColor.black
                           return label
                       }()
    let lblCancelationPolicyPrice: UILabel = {
                      let label = UILabel()
                      label.textAlignment = .left
                      label.text = ""
                      label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
                      label.numberOfLines = 0
                      label.textColor =  UIColor.black
                      return label
                  }()
    

    override init(frame: CGRect) {
           super.init(frame: frame)
           
           backgroundColor = .white

    addSubview(AdditionaLbl)
        AdditionaLbl.anchor(left: leftAnchor,  paddingLeft: 20,   width: 250, height: 50)
        
    addSubview(DriverLbl)
        DriverLbl.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 220, width: 250, height: 50)
        
        
    addSubview(DriverChargesPriceLabel)
         DriverChargesPriceLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 160, paddingBottom: 220, width: 250, height: 50)
        
    addSubview(NightHaltLbl)
        NightHaltLbl.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 200, width: 200, height: 50)
        
        
    addSubview(NightHaltPriceLabel)
          NightHaltPriceLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 180, paddingBottom: 200, width: 250, height: 50)
        
    addSubview(ConvienceFeeLbl)
          ConvienceFeeLbl.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 180, width: 250, height: 50)
        
    addSubview(lblRightConvienceFee)
          lblRightConvienceFee.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 150, paddingBottom: 180, width: 250, height: 50)
        
//    addSubview(lblFareRules)
//            lblFareRules.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 160, width: 250, height: 50)
//
//        addSubview(lblFareRulesPrice)
//                 lblFareRulesPrice.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 180, paddingBottom: 160, width: 250, height: 50)
        
    addSubview(lblBasicFare)
            lblBasicFare.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 160, width: 250, height: 50)
        
   addSubview(lblBasicFareprice)
            lblBasicFareprice.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 120, paddingBottom: 160, width: 250, height: 50)
                
        
    addSubview(lblTotalFare)
                lblTotalFare.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 140, width: 250, height: 50)
        
        addSubview(lblTotalFarePrice)
        lblTotalFarePrice.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 120, paddingBottom: 140, width: 250, height: 50)
        
    addSubview(lblMinChargedHour)
                lblMinChargedHour.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 120, width: 250, height: 50)
        
    addSubview(lblMinChargedHourPrice)
               lblMinChargedHourPrice.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 230, paddingBottom: 120, width: 250, height: 50)
              
    addSubview(lblExtraHourRate)
        lblExtraHourRate.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 100, width: 250, height: 50)
        
    addSubview(lblExtraHourRatePrice)
        lblExtraHourRatePrice.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 160, paddingBottom: 100, width: 250, height: 50)

        
    addSubview(lblCancelationPolicy)
               lblCancelationPolicy.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 80, width: 250, height: 50)
        
    addSubview(lblCancelationPolicyPrice)
        lblCancelationPolicyPrice.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 180, paddingBottom: 80, width: 250, height: 50)
        
    addSubview(btnTermsAndConditions)
            btnTermsAndConditions.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 60, width: 250, height: 50)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
