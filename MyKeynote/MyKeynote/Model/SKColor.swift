//
//  SKColor.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class SKColor: CustomStringConvertible {
    let red: UInt8
    let green: UInt8
    let blue: UInt8
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    var description: String { "R:\(red), G:\(green), B:\(blue)" }
    
    func toHex() -> String {
        "0x\(String(red, radix: 16))\(String(green, radix: 16))\(String(blue, radix: 16))"
    }
    
    func complementaryColor() -> SKColor {
        SKColor(red: 255 - red,
                green: 255 - green,
                blue: 255 - blue)
    }
    
    static func randomOne() -> SKColor {
        SKColor(red: UInt8.random(in: 0...255),
                      green: UInt8.random(in: 0...255),
                      blue: UInt8.random(in: 0...255))
    }
}
