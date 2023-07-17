//
//  SKColor.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

struct SKColor: CustomStringConvertible {
    let red: UInt8
    let green: UInt8
    let blue: UInt8
    let alpha: Int
    
    init(red: UInt8, green: UInt8, blue: UInt8, alpha: Int) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha > 10 ? 10 : (alpha < 0 ? 0 : alpha)
    }
    
    var description: String { "R:\(red), G:\(green), B:\(blue), Alpha: \(String(format: "%2d", alpha))" }
}
