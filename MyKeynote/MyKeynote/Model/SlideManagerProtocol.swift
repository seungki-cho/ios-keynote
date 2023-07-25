//
//  SlideManagerProtocol.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

protocol SlideManagerProtocol {
    mutating func makeRect<T: Rectable>(by type: T.Type, photo: Data?) -> T
    func changeAlpha(to alpha: Int)
    func changeColor(to color: SKColor)
    func tapped(at point: SKPoint, center: SKPoint)
    
    var count: Int { get }
    subscript(i: Int) -> Rectable? { get }
    
    var selectedRectDidChanged: ((Rectable?) -> ())? { get set }
    var changed: ((Rectable?) -> ())? { get set }
}
