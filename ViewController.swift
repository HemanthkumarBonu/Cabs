//
//  ViewController.swift
//  Cabs
//
//  Created by Hemanth kumar  on 14/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    var timer: Timer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        UIApplication.shared.statusBarView?.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true

        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateView), userInfo: nil, repeats: true)

    }

  @objc func updateView(){
    
        timer.invalidate()
    
        let vc = TripTypeViewController(nibName: "TripTypeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
   

        
    }
}


extension UIView{
    func CornerRadiousWithShadow(cornerRadus: CGFloat) {
        self.layer.cornerRadius = cornerRadus
        self.layer.shadowColor =  UIColor.lightGray.cgColor
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 1, height: 4.0)
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false

    }
}

extension UIViewController {
/// Display message in prompt view
///
/// — Parameters:
/// — title: Title to display Alert
/// — message: Pass string of content message
/// — options: Pass multiple UIAlertAction title like “OK”,”Cancel” etc
/// — completion: The block to execute after the presentation finishes.
func presentAlertWithTitleAndMessage(title: String, message: String, options: [String], completion: @escaping (Int) -> Void) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
            completion(index)
            }))
        }
    topMostViewController().present(alertController, animated: true, completion: nil)
}

/// Get the top most view in the app
/// — Returns: It returns current foreground UIViewcontroller
    func topMostViewController() -> UIViewController {
    var topViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topViewController?.presentedViewController) != nil) {
        topViewController = topViewController?.presentedViewController
        }
    return topViewController!
    }
}
