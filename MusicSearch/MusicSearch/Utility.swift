//
//  Utility.swift
//  MusicSearch
//
//  Created by Milan Shah on 10/1/17.
//  Copyright © 2017 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
class Utility: NSObject {
    
    class func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        var rgbValue: UInt32 = 0
        Scanner(string : cString).scanHexInt32(&rgbValue)
        return UIColor (red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                        alpha: CGFloat(1.0))
        
    }
    
}

extension String {
    func replace(target: String, withString : String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    mutating func addString (str : String){
        self = self + str
    }

}

extension UIColor {
    
    class func myOrangeColor () -> UIColor {
        let orangeHex: String = "#f2570b"
        return Utility.hexStringToUIColor(hex:orangeHex)
    }
    
    class func myLightGrayColor () -> UIColor {
        let lightGrayHex: String = "#95989a"
        return Utility.hexStringToUIColor(hex:lightGrayHex)
    }
    
    class func myDarkGrayColor () -> UIColor {
        let darkGrayHex: String = "#444444"
        return Utility.hexStringToUIColor(hex:darkGrayHex)
    }
    
    class func myWhiteSmokeColor () -> UIColor {
        let whiteSmokeHex: String = "#f9f9f9"
        return Utility.hexStringToUIColor(hex:whiteSmokeHex)
    }
    
    class func myLightGreenColor () -> UIColor {
        let lightGreenHex: String = "#878a2e"
        return Utility.hexStringToUIColor(hex:lightGreenHex)
    }
    
    class func myMountainColor () -> UIColor {
        let moutainHex: String = "#522a0e"
        return Utility.hexStringToUIColor(hex:moutainHex)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIScrollView {
    func resetScrollPositionToTop(){
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}

