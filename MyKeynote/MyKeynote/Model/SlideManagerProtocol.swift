//
//  SlideManagerProtocol.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

protocol SlideManagerProtocol {
    func changeAlpha(to alpha: Int)
    func changeColor(to color: SKColor)
    func tapped(at point: SKPoint, center: SKPoint)
    
    var count: Int { get }
    subscript(i: Int) -> Rectable? { get }
}
