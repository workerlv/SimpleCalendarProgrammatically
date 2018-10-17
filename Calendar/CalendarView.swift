//
//  CalendarView.swift
//  Calendar
//
//  Created by Arturs Vitins on 15/10/2018.
//  Copyright © 2018 Arturs Vitins. All rights reserved.
//

import UIKit

class CalendarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MonthViewDelegate {
    
    var numOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializerView()
    }
    
    func initializerView () {
        
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay()
        
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
        }
        
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        
        setupViews()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(dateCVCell.self, forCellWithReuseIdentifier: "Cell")

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! dateCVCell
        cell.backgroundColor = .clear

        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden = true
        } else {
            let calcDate = indexPath.row - firstWeekDayOfMonth + 2
            cell.isHidden = false
            cell.lbl.text = "\(calcDate)"
            cell.lbl.textColor = .black
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                
                cell.isUserInteractionEnabled = false
                cell.lbl.textColor = UIColor.lightGray
                
            } else {
                cell.isUserInteractionEnabled = true
                
            }

        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .clear
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor = UIColor.blue
        
        print(indexPath.item - firstWeekDayOfMonth + 2)
        print(currentMonthIndex)
        print(currentYear)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    
    }
    
    func getFirstWeekDay () -> Int {
        
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        return day
        
    }
    
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        currentMonthIndex = monthIndex + 1
        currentYear = year
        
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[monthIndex] = 29
            } else {
                numOfDaysInMonth[monthIndex] = 28
            }
        }
        
        firstWeekDayOfMonth = getFirstWeekDay()
        myCollectionView.reloadData()
        
        monthView.btnLeft.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
        
    }
    
    func setupViews() {
        
        addSubview(monthView)
        NSLayoutConstraint.activate([
            monthView.topAnchor.constraint(equalTo: topAnchor),
            monthView.leftAnchor.constraint(equalTo: leftAnchor),
            monthView.rightAnchor.constraint(equalTo: rightAnchor),
            monthView.heightAnchor.constraint(equalToConstant: 35)
            ])
        monthView.delegate = self
        
        addSubview(weekdaysView)
        NSLayoutConstraint.activate([
            weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor),
            weekdaysView.leftAnchor.constraint(equalTo: leftAnchor),
            weekdaysView.rightAnchor.constraint(equalTo: rightAnchor),
            weekdaysView.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        addSubview(myCollectionView)
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0),
            myCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            myCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            myCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
    }
    
    
    let monthView: MonthView = {
       let month = MonthView()
        month.translatesAutoresizingMaskIntoConstraints = false
        return month
    }()
    
    let weekdaysView: WeekdaysView = {
       let weekday = WeekdaysView()
        weekday.translatesAutoresizingMaskIntoConstraints = false
        return weekday
    }()
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.backgroundColor = UIColor.clear
        myCollectionView.allowsMultipleSelection = false
        return myCollectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension String {
    
    static var dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
    
}

extension Date {
    
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
}






