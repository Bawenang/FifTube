//
//  Extensions.swift
//  FifTube
//
//  Created by Poing on 1/20/18.
//  Copyright © 2018 FEMA. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func initRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        let color = UIColor (red: red / 255,green: green / 255,blue: blue / 255,alpha: 1)
        return color
    }
    
    static var navBarColor = initRGB(red: 28, green: 117, blue: 188)
    static var bgColor = initRGB(red: 229, green: 235, blue: 239)
}

extension DateFormatter {
    convenience init(dateStyle: Style) {
        self.init()
        self.locale = Locale.current
        self.dateStyle = dateStyle
    }
    convenience init(timeStyle: Style) {
        self.init()
        self.locale = Locale.current
        self.timeStyle = timeStyle
    }
    convenience init(dateStyle: Style, timeStyle: Style) {
        self.init()
        self.locale = Locale.current
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}

extension Date {
    static let shortDate = DateFormatter(dateStyle: .short)
    static let mediumDate = DateFormatter(dateStyle: .medium)
    static let fullDate = DateFormatter(dateStyle: .full)
    
    static let shortTime = DateFormatter(timeStyle: .short)
    static let mediumTime = DateFormatter(timeStyle: .medium)
    static let fullTime = DateFormatter(timeStyle: .full)
    
    static let shortDateTime = DateFormatter(dateStyle: .short, timeStyle: .short)
    static let mediumDateTime = DateFormatter(dateStyle: .full, timeStyle: .medium)
    static let fullDateTime = DateFormatter(dateStyle: .full, timeStyle: .full)
    
    var fullDate:  String { return Date.fullDate.string(from: self) }
    var mediumDate: String { return Date.mediumDate.string(from: self) }
    var shortDate: String { return Date.shortDate.string(from: self) }
    
    var fullTime:  String { return Date.fullTime.string(from: self) }
    var mediumTime: String { return Date.mediumTime.string(from: self) }
    var shortTime: String { return Date.shortTime.string(from: self) }
    
    var fullDateTime:  String { return Date.fullDateTime.string(from: self) }
    var mediumDateTime: String { return Date.mediumDateTime.string(from: self) }
    var shortDateTime: String { return Date.shortDateTime.string(from: self) }
}
