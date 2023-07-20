//
//  Rect.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

protocol Rect: CustomStringConvertible {
    var id: String { get }
    var height: Int { get set }
    var alpha: Int { get set }
    
    init(id: String, height: Int, alpha: Int, color: SKColor?, photo: Data?)
}

extension Rect {
    func isEqual(with rect: Rect) -> Bool {
        rect.id == id
    }
}
