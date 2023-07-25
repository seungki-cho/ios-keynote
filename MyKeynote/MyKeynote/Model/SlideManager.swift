//
//  SlideManager.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

class SlideManager: SlideManagerProtocol {
    //MARK: - Dependency
    private let rectFactory: RectFactoryProtocol
    
    //MARK: - Property
    private var slides: [Rectable] = []
    var count: Int { slides.count }
    
    //MARK: - Lifecycle
    init(rectFactory: RectFactoryProtocol) {
        self.rectFactory = rectFactory
    }
    
    //MARK: - Helper
    subscript(i: Int) -> Rectable? {
        (0..<slides.count) ~= i ? slides[i] : nil
    }
    func makeRect<T: Rectable>(by type: T.Type, photo: Data? = nil) -> T {
        let newRect = rectFactory.make(by: type, photo: photo)
        slides.append(newRect)
        return newRect
    }
    
    func changeAlpha(to alpha: Int) {
    }
    
    func changeColor(to color: SKColor) {
        rect.color = color
    }
    
    func tapped(at point: SKPoint, center: SKPoint) {
    }
}
