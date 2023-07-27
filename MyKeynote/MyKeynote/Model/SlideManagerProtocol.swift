//
//  SlideManagerProtocol.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

protocol SlideManagerProtocol: SlideColorful, SlideMakeable {
    func changeAlpha(to alpha: Int)

    func tapped(at point: SKPoint, center: SKPoint)
    func changeTableIndex(to index: Int?)
    
    var count: Int { get }
    subscript(i: Int) -> Rectable? { get }
}

protocol SlideColorful {
    func changeColor(to color: SKColor)
}

protocol SlideMakeable {
    func makeSquare()
}
