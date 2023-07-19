//
//  SKColor.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class SKColor: CustomStringConvertible {
    #warning("접근제어자?")
    let red: UInt8
    let green: UInt8
    let blue: UInt8
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    var description: String { "R:\(red), G:\(green), B:\(blue)" }
}
