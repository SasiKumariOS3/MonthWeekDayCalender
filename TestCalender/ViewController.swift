//
//  ViewController.swift
//  TestCalender
//
//  Created by Mac-OBS-06 on 08/04/19.
//  Copyright © 2019 OptisolBusinessSolutions. All rights reserved.
//

import UIKit
import JTAppleCalendar


//MARK : Extensions
extension String {
    
    func toDatewithFormat(format: String)-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from:self)!
        return date
    }
}

extension Date {
    
    func toStringwithFormat(format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var calendarWeekView: DefaultWeekView!
    @IBOutlet weak var calenderMonthView: JTAppleCalendarView!
    
    var minimumVisibleDate: Date?
    let viewModel = DefaultViewModel()
    var selectType = String()
    let currentCalendar = Calendar.autoupdatingCurrent
    var monthFormatter = DateFormatter()
    var mydateFormater = DateFormatter()
    var myCalendar = Calendar(identifier: .gregorian)
    var generateInDates: InDateCellGeneration = .forFirstMonthOnly
    var generateOutDates: OutDateCellGeneration = .off
    var hasStrictBoundaries = true
    let firstDayOfWeek: DaysOfWeek = .monday
    var tags = [UILabel]()
    var strSelTypeCalendr = ""
    
    let astologydates = [
        "2018-11-18",
        "2018-11-23",
        "2018-10-14",
        "2018-10-17",
        "2018-10-19",
        "2018-12-21",
        "2018-12-16"]
    
    let eventdates = [
        "2019-01-18",
        "2019-01-23",
        "2019-02-14",
        "2019-02-17",
        "2019-02-19",
        "2019-03-21",
        "2019-03-16"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let logoutBarButtonItem = UIBarButtonItem(title: "D W M", style: .done, target: self, action: #selector(calenderDidChange))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem

        self.title = "Month Week Day Calender"
        
//        calenderMonthView.register(supplementaryViewType: MonthCalendarHeader.self,
//                               ofKind: UICollectionView.elementKindSectionHeader)
        
      
        
        self.setupCalendarView()
        self.setupCalendar()
        self.calendarWeekView.isHidden = true

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Handle rotation
        calenderMonthView.collectionViewLayout.invalidateLayout()
    }
    
    // Support device orientation change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        JZWeekViewHelper.viewTransitionHandler(to: size, weekView: calendarWeekView)
    }
    
    //MARK : JTCalender Month view Setup
    private func setupCalendar() {
        
        calenderMonthView.register(UINib(nibName: "CalenderDateEventCell", bundle: nil), forCellWithReuseIdentifier: "CalenderDateEventCell")
        
        calenderMonthView.register(UINib(nibName: "CalenderEmptyCell", bundle: nil), forCellWithReuseIdentifier: "CalenderEmptyCell")
        
        calenderMonthView.register(MonthCalendarHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(MonthCalendarHeader.self))

        self.calenderMonthView.layer.borderWidth = 0.5
        self.calenderMonthView.layer.borderColor = JZWeekViewColors.gridLine.cgColor
        self.calenderMonthView.scrollDirection = .horizontal
        self.calenderMonthView.showsVerticalScrollIndicator = false
        self.calenderMonthView.showsHorizontalScrollIndicator = false
        self.calenderMonthView.isScrollEnabled = true
        self.calenderMonthView.isPagingEnabled = true
        self.calenderMonthView.isDirectionalLockEnabled = false
        self.calenderMonthView.ibCalendarDelegate = self
        self.calenderMonthView.ibCalendarDataSource = self
        self.calenderMonthView.scrollingMode = .stopAtEachSection
        self.calenderMonthView.cellSize = self.view.bounds.size.width / 7.0
        self.calenderMonthView.minimumInteritemSpacing = 0
        self.calenderMonthView.minimumLineSpacing = 0
        self.calenderMonthView.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.calenderMonthView.bounces = false
        self.scrolltoToday()
        
    }
   private func scrolltoToday() {
        self.calenderMonthView.selectDates([NSDate() as Date])
        self.calenderMonthView.scrollToDate(NSDate() as Date, animateScroll: false)
    }
    
    //MARK : JZCalender Week&Day view Setup
    private func setupCalendarView() {
        
        calendarWeekView.baseDelegate = self
        calendarWeekView.layer.borderWidth = 0.5
        calendarWeekView.layer.borderColor = JZWeekViewColors.gridLine.cgColor
        // Basic setup
        calendarWeekView.setupCalendar(numOfDays: 1,
                                       setDate: Date(),
                                       allEvents: viewModel.eventsByDate,
                                       scrollType: .pageScroll)
        // Optional
        calendarWeekView.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: JZHourGridDivision.noneDiv))
    }
    
    //MARK : - Business Logic -
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    fileprivate var visibleDates: DateSegmentInfo? {
        didSet {
            minimumVisibleDate = visibleDates?.monthDates.first?.date
            calenderMonthView.reloadData()
        }
    }
    
    //MARK : - IBACTION -
    @objc func calenderDidChange(sender : UIBarButtonItem){
        let buttonItemView = sender.value(forKey: "view") as? UIView

        let popVC = PopOverDropVc(nibName: "PopOverDropVc", bundle: nil)
        popVC.delegate = self
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = buttonItemView
        popOverVC?.sourceRect = CGRect(x:buttonItemView!.bounds.midX, y: buttonItemView!.bounds.maxY + 2, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 200, height: 200)
        self.present(popVC, animated: true)
    }
    
    
}

//Mark : CalenderDatasource we can set start date, end date, start day
extension ViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_: JTAppleCalendarView) -> ConfigurationParameters {
        let components = currentCalendar.dateComponents([.year], from: Date())
        guard let year = components.year else { return ConfigurationParameters(startDate: Date(), endDate: Date()) }
        let compFrom = DateComponents(calendar: currentCalendar, year: year - 1, month: 1, day: 1)
        let compTo = DateComponents(calendar: currentCalendar, year: year + 1, month: 12, day: 31)
        guard let dateFrom = self.currentCalendar.date(from: compFrom), let dateTo = self.currentCalendar.date(from: compTo) else {
            return ConfigurationParameters(startDate: Date(), endDate: Date())
        }
        
        return ConfigurationParameters(startDate: dateFrom, endDate: dateTo,
                                       firstDayOfWeek: DaysOfWeek(rawValue: Calendar.sCalender.firstWeekday) ?? .sunday)
    }
    
}

//Mark : JTCalenderDelegate
extension ViewController: JTAppleCalendarViewDelegate {
    
    
    func calendar(_: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date,cellState: CellState, indexPath: IndexPath) {
        let cell = calenderMonthView.dequeueReusableCell(withReuseIdentifier: "CalenderDateEventCell", for: indexPath) as! CalenderDateEventCell
        configure(cell: cell, date: date, cellState: cellState)
    }
    
    func calendar(_: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.visibleDates = visibleDates
        
       
        //        if let first = visibleDates.minimum, let last = visibleDates.maximum {
        //            //reportDatesRange(from: first, to: last)
        //        }
    }
    
   
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let headervw = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: NSStringFromClass(MonthCalendarHeader.self), for: indexPath)
        return headervw
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    
//    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range : (start: Date, end: Date),at indexPath: IndexPath) -> JTAppleCollectionReusableView {
//        let headerView = calendar.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MonthCalendarHeader", for: indexPath) as! MonthCalendarHeader
//       // let view = calendar.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: MonthCalendarHeader.self, for: indexPath)
//        return headerView
//    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState,
                  indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: "CalenderDateEventCell", for: indexPath) as! CalenderDateEventCell
        configure(cell: cell, date: date, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState _: CellState) {
        print("didSelectDate =  \(date)")
        
        
//        let popVC = SunRisePopupVC(nibName: "SunRisePopupVC", bundle: nil)
//        popVC.modalPresentationStyle = .popover
//        popVC.selectdate = date
//        let popOverVC = popVC.popoverPresentationController
//        popOverVC?.delegate = self
//        popOverVC?.sourceView = calendar
//        popOverVC?.sourceRect = CGRect(x:calendar.bounds.midX, y: calendar.bounds.midY - 30, width: 2, height: 2)
//        popVC.preferredContentSize = CGSize(width: 200, height: 200)
//        self.present(popVC, animated: true)
    }
    
    func configure(cell: CalenderDateEventCell, date: Date, cellState: CellState) {
        
        if currentCalendar.isDateInToday(date) {
            cell.vw_todaybac.backgroundColor = UIColor.red
            cell.vw_todaybac.layer.cornerRadius = cell.vw_todaybac.frame.size.height/2
        } else {
            cell.vw_todaybac.backgroundColor = UIColor.white
        }
        cell.lbl_Daytxt.text = dayFormatter.string(from: date)
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.lbl_Daytxt.alpha = 1
        } else {
            cell.lbl_Daytxt.alpha = 0.5
        }
        
        cell.vw_Events.showsVerticalScrollIndicator = true
        cell.vw_Events.isScrollEnabled = true
        cell.vw_Events.backgroundColor = UIColor.clear
        cell.vw_Events.isHidden = true
        
        cell.vw_Astrology.showsVerticalScrollIndicator = true
        cell.vw_Astrology.isScrollEnabled = true
        cell.vw_Astrology.backgroundColor = UIColor.clear
        cell.vw_Astrology.isHidden = true
        
        var yCoord: CGFloat = 3
        let datestr =  date.toStringwithFormat(format: "yyyy-MM-dd")
        
        //For Astrology
        if astologydates.contains(datestr) {
            cell.vw_todaybac.backgroundColor = UIColor.green
            cell.vw_todaybac.layer.cornerRadius = cell.vw_todaybac.frame.size.height/2
            cell.vw_Astrology.backgroundColor = .random
            cell.vw_Astrology.isHidden = false
            
            for index in 1...5 {
                let label = UILabel()
                label.frame = CGRect(x: 3, y: yCoord, width: cell.vw_DayBac.frame.size.width, height: 10)
                label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                label.font = UIFont.systemFont(ofSize: 8)  //UIFont(name: "CenturyGothic", size: 2)
                label.textColor = UIColor.white
                label.textAlignment = .left
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
                label.text = "item nameeeeee \(index)"
                yCoord = yCoord + label.frame.size.height + 1
                cell.vw_Astrology.addSubview(label)
            }
            cell.vw_Astrology.contentSize = CGSize(width: cell.vw_DayBac.frame.size.width, height:  yCoord + 30)
            
        } else {
            cell.vw_Astrology.backgroundColor = UIColor.clear
            cell.vw_Astrology.subviews.forEach({ $0.removeFromSuperview() })
            cell.vw_Astrology.isHidden = true
            
        }
        
        //For Events
        if eventdates.contains(datestr) {
            cell.vw_todaybac.backgroundColor = UIColor.blue
            cell.vw_todaybac.layer.cornerRadius = cell.vw_todaybac.frame.size.height/2
            cell.vw_Events.backgroundColor = UIColor.white
            cell.vw_Events.isHidden = false
            
            for index in 1...3 {
                let label = UILabel()
                label.frame = CGRect(x: 3, y: yCoord, width: cell.vw_DayBac.frame.size.width, height: 20)
                label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                label.font = UIFont.systemFont(ofSize: 8)  //UIFont(name: "CenturyGothic", size: 2)
                label.textColor = UIColor.white
                label.backgroundColor = .random
                label.textAlignment = .left
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
                label.text = "eventttttt nameeeeee \(index)"
                yCoord = yCoord + label.frame.size.height + 3
                cell.vw_Events.addSubview(label)
            }
            cell.vw_Events.contentSize = CGSize(width: cell.vw_DayBac.frame.size.width, height:  yCoord + 30)
            
        } else {
            cell.vw_Events.backgroundColor = UIColor.clear
            cell.vw_Events.subviews.forEach({ $0.removeFromSuperview() })
            cell.vw_Events.isHidden = true
            
        }
        cell.contentView.layoutIfNeeded()
    }
}

extension ViewController: JZBaseViewDelegate {
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
        print("initDate = ", initDate)
    }
}


extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension ViewController: PopOverDropVcDelegate {
    
    func selectedCalenderType(slcttype: String) {
        print("\(slcttype)")//
        selectType = slcttype
        switch slcttype {
        case "Day":
            calendarWeekView.setupCalendar(numOfDays: 1,
                                           setDate: Date(),
                                           allEvents: viewModel.eventsByDate,
                                           scrollType: .pageScroll)
            calenderMonthView.isHidden = true
            calendarWeekView.isHidden = false
        case "Week":
            calendarWeekView.setupCalendar(numOfDays: 7,
                                           setDate: Date(),
                                           allEvents: viewModel.eventsByDate,
                                           scrollType: .pageScroll)
            calenderMonthView.isHidden = true
            calendarWeekView.isHidden = false
        case "Month":
            calenderMonthView.isHidden = false
            calendarWeekView.isHidden = true
            calenderMonthView.scrollToDate(NSDate() as Date)
        default:
            break
        }
    }
    
    
    
}




