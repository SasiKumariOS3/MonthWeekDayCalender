//
//  CalenderHeaderCell.swift
//  TestCalender
//
//  Created by Mac-OBS-06 on 18/03/19.
//  Copyright © 2019 OptisolBusinessSolution. All rights reserved.
//

import UIKit
import JTAppleCalendar


class CalenderHeaderCell: JTAppleCollectionReusableView {

    @IBOutlet weak var vw_bac: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nibSetup()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        nibSetup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        nibSetup()
//    }
    
    private func nibSetup() {
        self.vw_bac.translatesAutoresizingMaskIntoConstraints = false
         vw_bac.frame.size.width = UIScreen.main.bounds.size.width - 10
    }

}
