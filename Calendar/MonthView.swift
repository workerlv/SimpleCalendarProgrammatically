//
//  MonthView.swift
//  Calendar
//
//  Created by Arturs Vitins on 15/10/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

protocol MonthViewDelegate: class {
    func didChangeMonth(monthIndex: Int, year: Int)
}

class MonthView: UIView {
    
    var monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var currentMonthIndex = 0
    var currentYear: Int = 0
    
    var delegate: MonthViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        
        setupViews()
        
        btnLeft.isEnabled = true
    }
    
    @objc func btnLeftRightAction(sender: UIButton) {
        
        if sender == btnRight {
            currentMonthIndex += 1
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
            }
        } else {
            currentMonthIndex -= 1
            if currentMonthIndex < 0 {
                currentMonthIndex = 11
                currentYear -= 1
            }
        }
        
        lblName.text = "\(monthArr[currentMonthIndex]) \(currentYear)"
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
        
    }
    
    func setupViews() {
        
        self.addSubview(lblName)
        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: topAnchor),
            lblName.centerXAnchor.constraint(equalTo: centerXAnchor),
            lblName.widthAnchor.constraint(equalToConstant: 150),
            lblName.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        
        lblName.text = "\(monthArr[currentMonthIndex]) \(currentYear)"
        
        self.addSubview(btnRight)
        NSLayoutConstraint.activate([
            btnRight.topAnchor.constraint(equalTo: topAnchor),
            btnRight.rightAnchor.constraint(equalTo: rightAnchor),
            btnRight.widthAnchor.constraint(equalToConstant: 50),
            btnRight.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        
        self.addSubview(btnLeft)
        NSLayoutConstraint.activate([
            btnLeft.topAnchor.constraint(equalTo: topAnchor),
            btnLeft.leftAnchor.constraint(equalTo: leftAnchor),
            btnLeft.widthAnchor.constraint(equalToConstant: 50),
            btnLeft.heightAnchor.constraint(equalTo: heightAnchor)
            ])
        
       
        
    }
    
    let lblName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Default Month Year text"
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let btnRight: UIButton = {
       let btn = UIButton()
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    let btnLeft: UIButton = {
        let btn = UIButton()
        btn.setTitle("<", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
        btn.setTitleColor(UIColor.lightGray, for: .disabled)
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

