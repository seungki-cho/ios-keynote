//
//  SlideManagerProtocol.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

protocol SlideManagerProtocol {
    mutating func makeRect(by type: Rect.Type, photo: Data?) -> Rect
    mutating func changeColor(for id: String, to color: SKColor)
}
