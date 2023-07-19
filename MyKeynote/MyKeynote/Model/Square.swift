//
//  Square.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class Square: Rect, CustomStringConvertible {
    let id: String
    private(set) var height: Int
    private(set) var color: SKColor
    @OneToTen private(set) var alpha: Int
    var description: String { "(\(id)), Height:\(height), \(color.description), Alpha:\(String(format: "%2d", alpha))" }
    
    init(id: String, color: SKColor, alpha: Int, height: Int) {
        self.id = id
        self.color = color
        self.alpha = alpha
        self.height = height
    }
}
