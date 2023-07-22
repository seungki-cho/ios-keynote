//
//  Rect.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/20.
//

import Foundation

class Rect: Rectable, Colorful {
    let id: String
    var point: SKPoint
    var height: Int
    var aspectRatio: Double { 4.0 / 3.0 }
    var color: SKColor
    @OneToTen var alpha: Int
    
    var description: String { "(\(id)), Height:\(height), \(color.description), Alpha:\(String(format: "%2d", alpha))" }
    
    required init(id: String, point: SKPoint, height: Int, alpha: Int, color: SKColor?, photo: Data? = nil) {
        self.id = id
        self.point = point
        self.height = height
        self.alpha = alpha
        self.color = color ?? SKColor.randomOne()
    }
}
