//
//  WeekdaysView.swift
//  Calendar
//
//  Created by Arturs Vitins on 15/10/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

class WeekdaysView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(myStackView)
        
        NSLayoutConstraint.activate([
            myStackView.topAnchor.constraint(equalTo: topAnchor),
            myStackView.leftAnchor.constraint(equalTo: leftAnchor),
            myStackView.rightAnchor.constraint(equalTo: rightAnchor),
            myStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        var daysArr = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
       
        for i in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[i]
            lbl.textAlignment = .center
            lbl.textColor = .black
            myStackView.addArrangedSubview(lbl)
        }
        
        
        
    }
    
    let myStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
