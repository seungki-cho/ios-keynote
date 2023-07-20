//
//  Colorful.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/20.
//

import Foundation

protocol Colorful {
    var color: SKColor { get set }
}

extension Colorful {
    mutating func changeColor(to color: SKColor) {
        self.color = color
    }
}
