//
//  JZColumnHeader.swift
//  JZCalendarWeekView
//
//  Created by Jeff Zhang on 28/3/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit

/// Header for each column (section, day) in collectionView (Supplementary View)
open class JZColumnHeader: UICollectionReusableView {
    
    public var lblDay = UILabel()
    public var lblWeekday = UILabel()
    public var numofDays = Int()
    let calendarCurrent = Calendar.current
    public var dateFormatter = DateFormatter()
    var stackView = UIStackView()
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        backgroundColor = .clear
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stackView = UIStackView(arrangedSubviews: [lblWeekday, lblDay])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = JZWeekViewColors.gridLine.cgColor
        addSubview(stackView)
        stackView.setAnchorConstraintsEqualTo(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor)
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = JZWeekViewColors.gridLine
        stackView.addSubview(bottomDivider)
        
        bottomDivider.setAnchorConstraintsEqualTo(widthAnchor: 0.5, topAnchor: (topAnchor,0), bottomAnchor: (bottomAnchor,0), trailingAnchor: (trailingAnchor,0.5))
        
        lblDay.textAlignment = .center
        lblWeekday.textAlignment = .center
        lblDay.font = UIFont.systemFont(ofSize: 17)
        lblWeekday.font = UIFont.systemFont(ofSize: 12)
    }
    
    public func updateView(date: Date) {
        
        let weekday = calendarCurrent.component(.weekday, from: date) - 1
        
        lblDay.text = String(calendarCurrent.component(.day, from: date))
        lblWeekday.text = dateFormatter.shortWeekdaySymbols[weekday].uppercased()
        
        lblWeekday.textColor = UIColor.darkText
        lblDay.textColor = UIColor.darkText
//
//        if numofDays == 1 {
//            lblWeekday.textColor = UIColor.white
//            lblDay.textColor = UIColor.white
////            self.backgroundColor =  UIColor.blue
//        }else{
//
//        }
        
//        if date.isToday {
//            lblDay.textColor = JZWeekViewColors.today
//            lblWeekday.textColor = JZWeekViewColors.today
//        } else {
//            lblDay.textColor = JZWeekViewColors.columnHeaderDay
//            lblWeekday.textColor = JZWeekViewColors.columnHeaderDay
//        }
    }
    
}
