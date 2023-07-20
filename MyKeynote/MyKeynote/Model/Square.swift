//
//  Square.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

final class Square: Rectable, Colorful {
    let id: String
    var height: Int
    var color: SKColor
    @OneToTen var alpha: Int
    
    var description: String { "(\(id)), Height:\(height), \(color.description), Alpha:\(String(format: "%2d", alpha))" }
    
    init(id: String, height: Int, alpha: Int, color: SKColor?, photo: Data? = nil) {
        self.id = id
        self.height = height
        self.alpha = alpha
        self.color = color ?? SKColor.randomOne()
    }
    
    func changeColor(to color: SKColor) {
        self.color = color
    }
}
