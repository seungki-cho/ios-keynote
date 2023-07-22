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
}
