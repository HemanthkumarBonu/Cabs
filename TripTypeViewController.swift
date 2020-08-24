//
//  TripTypeviewControllerViewController.swift
//  Cabs
//
//  Created by Hemanth kumar  on 14/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit

class TripTypeViewController: UIViewController {
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var viewOutstation: UIView!
    @IBOutlet weak var btnOutstation: UIButton!
    @IBOutlet weak var viewLocal: UIView!
    @IBOutlet weak var btnLocal: UIButton!
    @IBOutlet weak var btnTransfer: UIButton!
    @IBOutlet weak var viewTransfer: UIView!
    @IBOutlet weak var btnLetsGo: UIButton!
    @IBOutlet weak var imgCars: UIImageView!
    @IBOutlet weak var lblOutstation: UILabel!
    @IBOutlet weak var lblLocal: UILabel!
    @IBOutlet weak var lblTransfer: UILabel!
    
    var tripType = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.Shadow(view: viewOutstation)
        self.Shadow(view: viewLocal)
        self.Shadow(view: viewTransfer)
        
        self.setGoButtonHidden(isHidden: true)
    }
    func Shadow(view:UIView) {
         view.layer.shadowColor =  UIColor.lightGray.cgColor
         view.layer.shadowOpacity = 1
         view.layer.shadowOffset = .zero
         view.layer.shadowRadius = 5
         view.layer.shouldRasterize = true
         view.layer.rasterizationScale = UIScreen.main.scale
    }

    func setGoButtonHidden(isHidden:Bool){
        self.btnLetsGo.isHidden = isHidden
        
    }

    @IBAction func btnOutstationAccessed(_ sender: Any) {
        self.lblLocal.backgroundColor = UIColor.white
        self.lblTransfer.backgroundColor = UIColor.white
        self.lblOutstation.backgroundColor = UIColor.init(red: 47/255, green: 144/255, blue: 105/255, alpha: 1.0)
        tripType = 1
        self.setGoButtonHidden(isHidden: false)
        
    }
    
    @IBAction func btnLocalAccessed(_ sender: Any) {
        self.lblLocal.backgroundColor = UIColor.init(red: 47/255, green: 144/255, blue: 105/255, alpha: 1.0)
        self.lblTransfer.backgroundColor = UIColor.white
        self.lblOutstation.backgroundColor = UIColor.white
          tripType = 2
          self.setGoButtonHidden(isHidden: false)
    }
    @IBAction func btnTransferAccessed(_ sender: Any) {
        self.lblLocal.backgroundColor = UIColor.white
        self.lblTransfer.backgroundColor = UIColor.init(red: 47/255, green: 144/255, blue: 105/255, alpha: 1.0)
        self.lblOutstation.backgroundColor = UIColor.white
         tripType = 3
          self.setGoButtonHidden(isHidden: false)
    }
    
    
    @IBAction func btnLetsGo(_ sender: Any) {
         let vc = SearchingViewController(nibName: "SearchingViewController", bundle: nil)
       vc.masterTripType = self.tripType
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
