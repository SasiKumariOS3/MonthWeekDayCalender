//
//  DefaultViewModel.swift
//  JZCalendarViewExample
//
//  Created by Jeff Zhang on 3/4/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit


//extension Date {
//    
//    func add(component: Calendar.Component, value: Int) -> Date {
//        return Calendar.current.date(byAdding: component, value: value, to: self)!
//    }
//    
//    var startOfDay: Date {
//        return Calendar.current.startOfDay(for: self)
//    }
//}


class DefaultViewModel: NSObject {
    
    private let firstDate = Date().add(component: .hour, value: 1)
    private let secondDate = Date().add(component: .day, value: 1)
    private let thirdDate = Date().add(component: .day, value: 2)
    
    lazy var events = [DefaultEvent(id: "0", title: "Apple event", startDate: firstDate, endDate: firstDate.add(component: .hour, value: 1), location: "Mumbai"),
                       DefaultEvent(id: "1", title: "Developers Meetup", startDate: secondDate, endDate: secondDate.add(component: .hour, value: 4), location: "Bengalore"),
                       DefaultEvent(id: "2", title: "Marathon", startDate: thirdDate, endDate: thirdDate.add(component: .hour, value: 2), location: "Chennai"),
                       DefaultEvent(id: "3", title: "Festivel", startDate: thirdDate, endDate: thirdDate.add(component: .hour, value: 26), location: "Erode")]
    
    lazy var eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: events)
    
//    var currentSelectedData: OptionsSelectedData!
}
