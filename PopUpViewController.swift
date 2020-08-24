//
//  PopUpViewController.swift
//  Cabs
//
//  Created by Hemanth kumar  on 22/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit
protocol userDataDelegate {
    func getUserData(userData: UserInfo)
}

class PopUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var EnterDetailsView: UIView!
     @IBOutlet weak var txtEnterName: UITextField!
     @IBOutlet weak var txtEnterPhoneNo: UITextField!
     @IBOutlet weak var txtEmailId: UITextField!
     @IBOutlet weak var txtEnterYourAddress: UITextField!
   
    var delegate:userDataDelegate! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func cancelPopUp(_ sender: AnyObject) {
        self.removeAnimate()
      
    }
    @IBAction func bookCab(_ sender: Any) {
        if self.txtEnterName.text!.isEmpty || self.txtEmailId.text!.isEmpty || self.txtEnterPhoneNo.text!.isEmpty || self.txtEnterYourAddress.text!.isEmpty {
            self.presentAlertWithTitleAndMessage(title: "Cabs", message: "Please select all the options to continue your search.", options: ["Ok"]) { (option) in
                              
                          }
                          return
                      }
        self.view.endEditing(true)
        let userInfo = UserInfo()
        userInfo.name = self.txtEnterName.text!
        userInfo.emailId = self.txtEmailId.text!
        userInfo.phoneNo = self.txtEnterPhoneNo.text!
        userInfo.address = self.txtEnterYourAddress.text!
        self.removeAnimate()
        self.delegate.getUserData(userData: userInfo)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
