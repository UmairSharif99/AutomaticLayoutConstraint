//
//  AutomaticLayoutConstraint.swift
//  QUFAB
//
//  Created by Syed Qamar Abbas on 2/18/19.
//  Copyright © 2019 Muhammad Umair. All rights reserved.
//

import UIKit
fileprivate let defaultConstValue: CGFloat = -1.01

class AutomaticLayoutConstraint: NSLayoutConstraint {
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: firstItem)
        (firstItem as? NSObject)?.removeObserver(self, forKeyPath: keyBind)
    }
    
    fileprivate var isInitialized = false
    fileprivate var isObserverAttached = false
    fileprivate var isObserverChangeApplied = false
    fileprivate var animated_ = false
    fileprivate var iPhone4S_: CGFloat = -1.01
    fileprivate var iPhone5S_: CGFloat = -1.01
    fileprivate var iPhone6S_: CGFloat = -1.01
    fileprivate var iPhone6Plus_: CGFloat = -1.01
    fileprivate var iPhoneXS_: CGFloat = -1.01
    fileprivate var iPhoneXSMax_: CGFloat = -1.01
    fileprivate var actualConstant: CGFloat = 0.0
    fileprivate var keyConstant_: CGFloat = -1.01
    fileprivate var keyBind_: String = ""
    fileprivate var observingValue: NSObject?
    fileprivate var duration_: TimeInterval = -1.01
    
    @IBInspectable var duration: Double {
        set{
            initializeValues()
            duration_ = newValue
        }
        get{
            return duration_
        }
    }
    @IBInspectable var animated: Bool {
        set{
            initializeValues()
            animated_ = newValue
        }
        get{
            return animated_
        }
    }
    @IBInspectable var keyConstant: CGFloat {
        set{
            initializeValues()
            keyConstant_ = newValue
        }
        get{
            return keyConstant_
        }
    }
    @IBInspectable var keyBind: String {
        set{
            keyBind_ = newValue
            initializeValues()
        }
        get{
            return keyBind_
        }
    }
    @IBInspectable var iPhone4S: CGFloat {
        set{
            initializeValues()
            iPhone4S_ = newValue
        }
        get{
            return iPhone4S_
        }
    }
    @IBInspectable var iPhone5S: CGFloat {
        set{
            initializeValues()
            iPhone5S_ = newValue
        }
        get{
            return iPhone5S_
        }
    }
    @IBInspectable var iPhone6S: CGFloat {
        set{
            initializeValues()
            iPhone6S_ = newValue
        }
        get{
            return iPhone6S_
        }
    }
    @IBInspectable var iPhone6Plus: CGFloat {
        set{
            initializeValues()
            iPhone6Plus_ = newValue
        }
        get{
            return iPhone6Plus_
        }
    }
    @IBInspectable var iPhoneXS: CGFloat {
        set{
            initializeValues()
            iPhoneXS_ = newValue
        }
        get{
            return iPhoneXS_
        }
    }
    @IBInspectable var iPhoneXSMax: CGFloat {
        set{
            initializeValues()
            iPhoneXSMax_ = newValue
        }
        get{
            return iPhoneXSMax_
        }
    }
    override var constant: CGFloat {
        set{
            super.constant = newValue
        }
        get {
            return getConstant(for: actualConstant)
        }
    }
    func getConstant(for newValue: CGFloat) -> CGFloat {
        var finalConstant = newValue
        let size = UIScreen.main.bounds.size
        let deviceBySize = "\(Int(size.width)),\(Int(size.height))"
        if let type = DeviceType(rawValue: deviceBySize) {
            switch type {
            case .iPhone4S:
                if iPhone4S != defaultConstValue {
                    finalConstant = iPhone4S
                }
                break
            case .iPhone5S:
                if iPhone5S != defaultConstValue {
                    finalConstant = iPhone5S
                }
                break
            case .iPhone6S:
                if iPhone6S != defaultConstValue {
                    finalConstant = iPhone6S
                }
                break
            case .iPhone6Plus:
                if iPhone6Plus != defaultConstValue {
                    finalConstant = iPhone6Plus
                }
                break
            case .iPhoneXS:
                if iPhoneXS != defaultConstValue {
                    finalConstant = iPhoneXS
                }
                break
            case .iPhoneXSMax:
                if iPhoneXSMax != defaultConstValue {
                    finalConstant = iPhoneXSMax
                }
                break
            }
        }
        if isObserverChangeApplied {
            return keyConstant
        }
        if finalConstant != defaultConstValue {
            return finalConstant
        }
        return newValue
    }
    fileprivate func initializeValues() {
        if !isInitialized {
            isInitialized = true
            resetValues()
        }
        if !isObserverAttached, !keyBind_.isEmpty, let item = firstItem as? NSObject {
            observingValue = item
            addObserver(on: item, with: keyBind_)
        }
    }
    fileprivate func resetValues() {
        actualConstant = super.constant
        animated_ = false
        duration = 0.1
        iPhone4S_ = -1.01
        iPhone5S_ = -1.01
        iPhone6S_ = -1.01
        iPhone6Plus_ = -1.01
        iPhoneXS_ = -1.01
        iPhoneXSMax_ = -1.01
    }
    fileprivate func addObserver(on item: NSObject, with key: String) {
        if !key.isEmpty, !isObserverAttached {
            self.checkContentAvailability()
            isObserverAttached = true
            item.addObserver(self, forKeyPath: key, options: [.new, .old], context: nil)
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == keyBind {
            checkAndSetConstantValue()
        }
    }
    @objc fileprivate func checkAndSetConstantValue() {
        checkContentAvailability()
        if let view = (firstItem as? UIView)?.superview {
            view.layoutIfNeeded()
            super.constant = 0.0
            if animated_ {
                UIView.animate(withDuration: duration_) {
                    let value = self.getConstant(for: self.actualConstant)
                    super.constant = value
                    view.layoutIfNeeded()
                }
            }else {
                super.constant = self.constant
                view.layoutIfNeeded()
            }
        }
    }
    @objc fileprivate func textIsChanging(notification: Notification) {
        if let item1 = notification.object as? NSObject, let item2 = firstItem as? NSObject, item1 == item2 {
            checkAndSetConstantValue()
        }
    }
    fileprivate func checkContentAvailability() {
        if let view = firstItem as? UIImageView {
            isObserverChangeApplied = view.image == nil
        }else if let view = firstItem as? UILabel {
            isObserverChangeApplied = view.text?.count == 0
        }else if let view = firstItem as? UITextField {
            if !isObserverAttached {
                view.addTarget(self, action: #selector(checkAndSetConstantValue), for: .editingChanged)
            }
            isObserverChangeApplied = view.text?.count == 0
        }else if let view = firstItem as? UITextView {
            if !isObserverAttached {
                NotificationCenter.default.addObserver(self, selector: #selector(textIsChanging(notification:)), name: UITextView.textDidChangeNotification, object: firstItem)
            }
            isObserverChangeApplied = view.text?.count == 0
        }else if let view = firstItem as? UIButton {
            if let count = view.titleLabel?.text?.count {
                if count == 0 {
                    isObserverChangeApplied = view.imageView?.image == nil
                }else {
                    isObserverChangeApplied = true
                }
            }else {
                isObserverChangeApplied = false
            }
        }else {
            isObserverChangeApplied = false
        }
    }
}
