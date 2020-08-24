//
//  ProfileCell.swift
//  Cabs
//
//  Created by Hemanth kumar  on 14/05/20.
//  Copyright © 2020 Hemanth kumar . All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            cellImageView.image = image
        }
    }
  
    let cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "KMS-1")
        iv.contentMode = .center
        iv.clipsToBounds = true
        return iv
    }()
    
    let imgLabel: UILabel = {
         let label = UILabel()
         label.textAlignment = .center
         label.text = "KMS-1"
         label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.black
         return label
     }()
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellImageView)
//        cellImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        addSubview(imgLabel)
//        imgLabel.anchor(top: cellImageView., left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
