//
//  PopOverDropVc.swift
//  TestCalender
//
//  Created by Mac-OBS-06 on 25/03/19.
//  Copyright © 2019 OptisolBusinessSolution. All rights reserved.
//

import UIKit

class PopoverBackgroundView: UIPopoverBackgroundView {
    
    override static func contentViewInsets() -> UIEdgeInsets {
        return .zero
    }
    
    override static func arrowBase() -> CGFloat {
        return 0
    }
    
    override static func arrowHeight() -> CGFloat {
        return 0
    }
    
    private var theArrowDirection: UIPopoverArrowDirection = .any
    
    override var arrowDirection: UIPopoverArrowDirection {
        get { return theArrowDirection }
        set { theArrowDirection = newValue }
    }
    
    private var theArrowOffset: CGFloat = 0
    
    override var arrowOffset: CGFloat {
        get { return theArrowOffset }
        set { theArrowOffset = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 30
        layer.shadowColor = UIColor.clear.cgColor
        
        //        layer.shadowOpacity = 0
        //        layer.shadowOffset = CGSize(width: 0, height: 0)
        //        layer.shadowRadius = 0
        
        // theme[.popupBackground].bind(to: rx.backgroundColor).disposed(by: disposeBag)
        //        theme[.shadow].subscribe(onNext: { [weak self] (color) in
        //            self?.layer.shadowColor = color.withAlphaComponent(0.25).cgColor
        //        }).disposed(by: disposeBag)
    }
    
    required init?(coder _: NSCoder) {
        fatalError()
    }
}

extension UIViewController {
    
    
    func withPopover(_ popoverConfiguration: (UIPopoverPresentationController) -> Void) -> Self {
        modalPresentationStyle = .popover
        
        if let popover = self.popoverPresentationController {
            popover.popoverBackgroundViewClass = PopoverBackgroundView.self
            popoverConfiguration(popover)
        }
        
        return self
    }
}

protocol PopOverDropVcDelegate : class {
    func selectedCalenderType(slcttype : String)
}

class PopOverDropVc: UIViewController {

    @IBOutlet weak var tbl_drop: UITableView!
    
    weak var delegate: PopOverDropVcDelegate?

     let myArray: NSArray = ["Day","Week","Month"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_drop.register(UINib(nibName: "DropdwntblCell", bundle: Bundle.main), forCellReuseIdentifier: "DropdwntblCell")
    }
}


extension PopOverDropVc : UITableViewDelegate,UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdwntblCell", for: indexPath) as! DropdwntblCell
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
        delegate?.selectedCalenderType(slcttype: "\(myArray[indexPath.row])")
        self.dismiss(animated: true, completion: nil)
    }
}
