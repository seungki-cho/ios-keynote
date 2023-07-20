//
//  UIColor+.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/21.
//

import UIKit

extension UIColor {
    convenience init(skColor: SKColor, skAlpha: Int) {
        self.init(red: Double(skColor.red) / 255,
                  green: Double(skColor.green) / 255,
                  blue: Double(skColor.blue) / 255,
                  alpha: Double(skAlpha) / 10)
    }
}
