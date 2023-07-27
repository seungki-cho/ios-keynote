//
//  UIView+.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/21.
//

import UIKit

extension UIView {
    var isSelected: Bool {
        get {
            self.layer.borderWidth != 0
        }
        set {
            self.layer.borderWidth = newValue ? 3 : 0
            self.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    func changeBackgroundAlpha(to alpha: CGFloat) {
        var (red, green, blue): (CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0)
        backgroundColor?.getRed(&red, green: &green, blue: &blue, alpha: nil)
        backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func changeBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        var alpha: CGFloat = 1.0
        backgroundColor?.getRed(nil, green: nil, blue: nil, alpha: &alpha)
        backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
