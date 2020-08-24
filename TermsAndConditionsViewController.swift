//
//  TermsAndConditionsViewController.swift
//  Cabs
//
//  Created by hemanthkumar bonu on 13/06/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {
   
    @IBOutlet weak var lblTermsAndConditions: UILabel!
    var htmlString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblTermsAndConditions.text = htmlString.html2String
        // Do any additional setup after loading the view.
    }
    

    @IBAction func okBtnAccessed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAnimate()
       {
           self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           self.view.alpha = 0.0;
           UIView.animate(withDuration: 0.25, animations: {
               self.view.alpha = 1.0
               self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           });
       }
       
       func removeAnimate()
       {
           UIView.animate(withDuration: 0.25, animations: {
               self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               self.view.alpha = 0.0;
               }, completion:{(finished : Bool)  in
                   if (finished)
                   {
                       self.view.removeFromSuperview()
                   }
           });
       }

}
