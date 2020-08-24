//
//  AvailbleCabsViewController.swift
//  Cabs
//
//  Created by Hemanth kumar  on 18/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit

class AvailbleCabsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var btnBck: UIButton!
    @IBOutlet weak var vwFilter: UIView!
    @IBOutlet weak var cabCollectionView: UICollectionView!
    
    var index = Int()
    var selectedIndex = Int()
    var availableCabs:[AvailableCab]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.vwFilter.isHidden = true
        cabCollectionView.register(UINib(nibName: "AvailbleCabCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "Cell")

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.availableCabs.count
     }
     
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cabDetails = self.availableCabs[indexPath.row]
    
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AvailbleCabCollectionViewCell
           cell.backgroundColor = UIColor.white
           cell.layer.cornerRadius = 25.0
           cell.layer.shadowPath =
                 UIBezierPath(roundedRect: cell.bounds,
                 cornerRadius: cell.layer.cornerRadius).cgPath
           cell.layer.shadowColor = UIColor.black.cgColor
           cell.layer.shadowOpacity = 0.5
           cell.layer.shadowOffset = CGSize(width: 5, height: 5)
           cell.layer.shadowRadius = 5
           cell.layer.masksToBounds = false
           cell.lblCarCompany.text = cabDetails.cabCategory
           cell.lblCarName.text = cabDetails.name
           cell.lblPrice.text = "\(cabDetails.totalAmount)"
    if cabDetails.name == "Toyota Innova" {
        cell.imgcar.image = UIImage(named: "toyoto_innova")
    } else if cabDetails.name == "Tempo Traveller (12 + 1 seater)" {
        cell.imgcar.image = UIImage(named: "Traveller")
    } else if cabDetails.name == "Toyota Camry or Equivalent" {
        cell.imgcar.image = UIImage(named: "camry")
    }else if cabDetails.name == "Toyota Corolla or Equivalent" {
        cell.imgcar.image = UIImage(named: "corolla")
    } else if cabDetails.name == "Toyota Etios or Equivalent" {
        cell.imgcar.image = UIImage(named: "etios-car")
    } else if cabDetails.name == "Honda City or Equivalent" {
        cell.imgcar.image = UIImage(named: "Honda-city")
    } else if cabDetails.name == "Toyota Innova Cresta" {
        cell.imgcar.image = UIImage(named: "cresta")
    } else {
        cell.imgcar.image = UIImage(named: "cresta")
    }
    
    let btnBook = cell.viewWithTag(105) as! UIButton
           btnBook.addTarget(self, action: #selector(btnBookClicked(_:)), for: UIControl.Event.touchUpInside)

           return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width-60, height: 220)
    }
    
    @IBAction func btnBckAcceessed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFilterClicked(_ sender: Any) {
        self.cabCollectionView.alpha = 1
         self.vwFilter.isHidden = false
    }
    @objc func btnBookClicked(_ sender: UIButton){
        
        let cell = sender.superview!.superview!
        let indexPath = self.cabCollectionView.indexPath(for: cell as! AvailbleCabCollectionViewCell)
        let vc = CabDetailsViewController(nibName: "CabDetailsViewController", bundle: nil)
        vc.cabDetails = self.availableCabs![indexPath!.item]
         self.navigationController?.pushViewController(vc, animated: true)
    }
}
