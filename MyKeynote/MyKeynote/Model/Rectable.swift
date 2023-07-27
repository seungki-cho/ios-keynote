//
//  Rect.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

protocol Rectable: CustomStringConvertible {
    var id: SKID { get }
    var height: Int { get set }
    var aspectRatio: Double { get }
    var alpha: Int { get set }
    var isSelected: Bool { get set }
}

extension Rectable {
    func isEqual(with rect: Rectable) -> Bool {
        rect.id == id
    }
    
    func getWidth() -> Double {
        Double(height) * aspectRatio
    }
    
    func contains(point: SKPoint, where center: SKPoint) -> Bool {
        let isXInRange = (center.x - getWidth() / 2)...(center.x + getWidth() / 2) ~= point.x
        let isYInRange = (center.y - Double(height) / 2)...(center.y + Double(height) / 2) ~= point.y
        return isXInRange && isYInRange
    }
    
    mutating func changeAlpha(to alpha: Int) {
        self.alpha = alpha
    }
}
