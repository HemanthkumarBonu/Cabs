//
//  ProfileHeader.swift
//  Cabs
//
//  Created by Hemanth kumar  on 14/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate {
    func btnBackClicked()
}
class ProfileHeader: UICollectionReusableView {
    
    let navigationController = UINavigationController()
     var delegate: ProfileHeaderDelegate! = nil
    // MARK: - Properties
    lazy var btnBack: UIButton = {
          let button = UIButton(type: .system)
          button.setImage(#imageLiteral(resourceName: "Bck").withRenderingMode(.alwaysOriginal), for: .normal)
//          button.addTarget(self, action: #selector(handleMessageUser), for: .touchUpInside)
          button.addTarget(self, action: #selector(self.btnBackClicked), for: .touchUpInside)
          return button
      }()
    
    let CircleImageView: UIImageView = {
          let cv = UIImageView()
          cv.clipsToBounds = true
        cv.backgroundColor = UIColor(red: 47/255, green: 144/255, blue: 105/255, alpha: 1)
          cv.layer.borderWidth = 0
          return cv
      }()
      
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "toyoto_innova")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0
        return iv
    }()
    
    
    let CompanyName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Toyota"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    let CarName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        
        addSubview(CircleImageView)
//        CircleImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        CircleImageView.anchor(top: topAnchor, right: rightAnchor,
                                          paddingTop: -5, paddingRight: -100, width: 305, height: 305)
                CircleImageView.layer.cornerRadius = 305 / 2
        
        addSubview(profileImageView)
             profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
             profileImageView.anchor(top: topAnchor, paddingTop: 100,
                                     width: 250, height: 150)
        
        addSubview(btnBack)
        btnBack.anchor(top: topAnchor, left: leftAnchor,
                             paddingTop: 35, paddingLeft: 15, width: 32, height: 32)
        
        addSubview(CompanyName)
         CompanyName.anchor(top: topAnchor, left: leftAnchor,
                                     paddingTop: 64, paddingLeft: 30, width: 220, height: 30)
        
        addSubview(CarName)
        CarName.anchor(top: topAnchor, left: leftAnchor,
                                            paddingTop: 90, paddingLeft: 30, width: 220, height: 30)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func btnBackClicked(sender: Any) {
           delegate?.btnBackClicked()
       }
//    @objc func buttonClicked() {
//        self.navigationController.popViewController(animated: true)
//    }
    
    @objc func handleFollowUser() {
        print("Follow user here..")
    }
    
}
