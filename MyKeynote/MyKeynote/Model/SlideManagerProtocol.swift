//
//  SlideManagerProtocol.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

protocol SlideManagerProtocol {
    mutating func makeRect(by type: Rectable.Type, photo: Data?) -> Rectable
    mutating func changeAlpha(to alpha: Int)
    mutating func changeColor(to color: SKColor)
    mutating func tapped(at point: SKPoint)
    
    var count: Int { get }
    
    subscript(i: Int) -> Rectable? { get }
}
