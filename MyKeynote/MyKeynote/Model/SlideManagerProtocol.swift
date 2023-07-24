//
//  SlideManagerProtocol.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

protocol SlideManagerProtocol {
    mutating func makeRect<T: Rectable>(by type: T.Type, photo: Data?) -> T
    mutating func changeAlpha(to alpha: Int)
    mutating func changeColor(to color: SKColor)
    mutating func tapped(at point: SKPoint, center: SKPoint)
    
    var count: Int { get }
    subscript(i: Int) -> Rectable? { get }
    
    var selectedRectDidChanged: ((Rectable?) -> ())? { get set }
    var changed: ((Rectable?) -> ())? { get set }
}
