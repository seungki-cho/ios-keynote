//
//  Square.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class Square: Rect, CustomStringConvertible {
    let id: String
    private(set) var height: Double
    private(set) var color: SKColor
    var description: String { "(\(id)), Height:\(height), \(color.description)" }
    
    init(id: String, color: SKColor, height: Double) {
        self.id = id
        self.color = color
        self.height = height
    }
}
