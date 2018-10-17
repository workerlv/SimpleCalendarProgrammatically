//
//  dateCVCell.swift
//  Calendar
//
//  Created by Arturs Vitins on 17/10/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

class dateCVCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(lbl)
        NSLayoutConstraint.activate([
            lbl.topAnchor.constraint(equalTo: topAnchor),
            lbl.leftAnchor.constraint(equalTo: leftAnchor),
            lbl.rightAnchor.constraint(equalTo: rightAnchor),
            lbl.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    let lbl: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
