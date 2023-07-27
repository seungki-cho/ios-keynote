//
//  Rect.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/20.
//

import Foundation

class Rect: Rectable, Colorful {
    let id: SKID
    var height: Int
    var aspectRatio: Double { 4.0 / 3.0 }
    var color: SKColor
    var isSelected: Bool = false
    @OneToTen var alpha: Int
    
    var description: String { "(\(id)), Height:\(height), \(color.description), Alpha:\(String(format: "%2d", alpha))" }
    
    required init(id: SKID, height: Int, alpha: Int, color: SKColor) {
        self.id = id
        self.height = height
        self.alpha = alpha
        self.color = color
    }
}
