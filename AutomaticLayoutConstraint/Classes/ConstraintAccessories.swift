//
//  ConstraintAccessories.swift
//  QUFAB
//
//  Created by Syed Qamar Abbas on 2/18/19.
//  Copyright © 2019 Muhammad Umair. All rights reserved.
//

import UIKit
extension String {
    var intValue: Int {
        if let value = Int(self) {
            return value
        }
        return 0
    }
}

typealias Size = (CGFloat, CGFloat)
enum DeviceType: String {
    
    case iPhone4S = "320,480"
    case iPhone5S = "320,568"
    case iPhone6S = "375,667"
    case iPhone6Plus = "414,736"
    case iPhoneXS = "375,812"
    case iPhoneXSMax = "414,896"
    var size: CGSize {
        if let first = self.rawValue.components(separatedBy: ",").first, let last = self.rawValue.components(separatedBy: ",").last {
            return CGSize(width: first.intValue, height: last.intValue)
        }
        return CGSize.zero
    }
}


