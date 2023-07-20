//
//  Rect.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

protocol Rectable: CustomStringConvertible {
    var id: String { get }
    var point: SKPoint { get set }
    var height: Int { get set }
    var aspectRatio: Double { get }
    var alpha: Int { get set }
    
    init(id: String, point: SKPoint, height: Int, alpha: Int, color: SKColor?, photo: Data?)
}

extension Rectable {
    func isEqual(with rect: Rectable) -> Bool {
        rect.id == id
    }
}
