//
//  CalenderDateEventCell.swift
//  CustomeCalender
//
//  Created by Mac-OBS-06 on 18/03/19.
//  Copyright © 2019 OptisolBusinessSolution. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalenderDateEventCell:  JTAppleCell {
    
    @IBOutlet weak var vw_DayBac: UIView!
    @IBOutlet weak var vw_todaybac: UIView!
    @IBOutlet weak var lbl_Daytxt: UILabel!
    @IBOutlet weak var vw_Events: UIScrollView!
    @IBOutlet weak var vw_Astrology: UIScrollView!
    // @IBOutlet weak var vw_Events: EventtagView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vw_Events.showsVerticalScrollIndicator = true
        vw_Events.isScrollEnabled = true
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = JZWeekViewColors.gridLine.cgColor
        
        vw_Astrology.showsVerticalScrollIndicator = true
        vw_Astrology.isScrollEnabled = true
    }

  
}
