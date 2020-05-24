//
//  UIColorExtension.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//

import UIKit

extension UIColor {
    static let grey0 = UIColor(hexString: "#F8F9FA")
    static let grey1 = UIColor(hexString: "#F1F3F5")
    static let grey2 = UIColor(hexString: "#E9ECEF")
    static let grey3 = UIColor(hexString: "#DEE2E6")
    static let grey4 = UIColor(hexString: "#CED4DA")
    static let grey5 = UIColor(hexString: "#ADB5BD")
    static let grey6 = UIColor(hexString: "#868E96")
    static let grey7 = UIColor(hexString: "#495057")
    static let grey8 = UIColor(hexString: "#343A40")
    static let grey9 = UIColor(hexString: "#212529")
    
    static let primary0 = UIColor(hexString: "#FFF4E6")
    static let primary1 = UIColor(hexString: "#FFE8CC")
    static let primary2 = UIColor(hexString: "#FFD8A8")
    static let primary3 = UIColor(hexString: "#FFC078")
    static let primary4 = UIColor(hexString: "#FFA94D")
    static let primary5 = UIColor(hexString: "#FF922B")
    static let primary6 = UIColor(hexString: "#FD7E14")
    static let primary7 = UIColor(hexString: "#F76707")
    static let primary8 = UIColor(hexString: "#E8590C")
    static let primary9 = UIColor(hexString: "#D9480F")
    
    static let likeRed =  UIColor(hexString: "#ee4957")
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func rgb (_ r: CGFloat, _ g: CGFloat, _ b:CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
