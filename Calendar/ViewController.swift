//
//  ViewController.swift
//  Calendar
//
//  Created by Arturs Vitins on 15/10/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calender"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        
        view.addSubview(calenderView)
        NSLayoutConstraint.activate([
            calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            calenderView.heightAnchor.constraint(equalToConstant: 365)
            ])
        
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
//    }
    
    
    let calenderView: CalendarView = {
        let calendar = CalendarView()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    

}

