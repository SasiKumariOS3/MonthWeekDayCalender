// ENVNT
// Created by Roll'n'Code team for Jesse Rakusin.

import JTAppleCalendar

import UIKit

class MonthCalendarHeader: JTAppleCollectionReusableView {

    let contentView = UIView()
    var stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        addSubview(contentView)
        contentView.setAnchorConstraintsEqualTo(topAnchor: (topAnchor, 0), bottomAnchor: (bottomAnchor, 0), leadingAnchor: (leadingAnchor, 0), trailingAnchor: (trailingAnchor, 0))
        
        stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        contentView.addSubview(stackView)
        stackView.setAnchorConstraintsEqualTo(topAnchor: (topAnchor, 0), bottomAnchor: (bottomAnchor, 0), leadingAnchor: (leadingAnchor, 0), trailingAnchor: (trailingAnchor, 0))

        var symbols = Calendar.sCalender.veryShortWeekdaySymbols

        if Calendar.sCalender.firstWeekday > 1 {
            for _ in 1 ..< Calendar.sCalender.firstWeekday {
                if let first = symbols.first {
                    symbols.append(first)
                    symbols.remove(at: 0)
                }
            }
        }

        for weekDay in symbols {
            let label = UILabel()
            label.textAlignment = .center
            label.text = weekDay
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.lightGray.cgColor
            stackView.addArrangedSubview(label)
           // self.updateBorder(textField: label, color: UIColor.lightGray, width: 0.5)
            

           // contentView.addSubview(label)

//            label.snp.makeConstraints { make in
//                make.top.equalToSuperview()
//                make.bottom.equalToSuperview()
//                if last == nil { make.left.equalToSuperview() }
//            }

//            if let prev = last {
//                let separator = UIView()
//                separator.layer.borderWidth = 2.0
//                separator.layer.borderColor = UIColor.lightGray.cgColor
//                //Views.calendarWeekDaySeparator(disposeBag: disposeBag)
//                contentView.addSubview(separator)
////                separator.snp.makeConstraints { make in
////                    make.top.equalToSuperview()
////                    make.bottom.equalToSuperview()
////                    make.left.equalTo(prev.snp.right)
////                    make.width.equalTo(1)
////                }
////
////                label.snp.makeConstraints { make in
////                    make.left.equalTo(separator.snp.right)
////                    make.width.equalTo(prev.snp.width)
////                }
//            }

          //  last = label
        }

//        if let last = last {
//            last.snp.makeConstraints { make in
//                make.right.equalToSuperview()
//            }
//        }
    }

    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    func updateBorder(textField: UILabel, color: UIColor, width: CGFloat) -> Void {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: textField.frame.size.width-10, y: 0, width: width, height: textField.frame.size.height);
    }
}
