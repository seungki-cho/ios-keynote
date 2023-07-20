//
//  SlideManager.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

struct SlideManager: SlideManagerProtocol {
    //MARK: - Dependency
    private let rectFactory: RectFactoryProtocol
    
    //MARK: - Property
    private var slides: [Rectable] = []
    private var selectedRect: Rectable?
    var count: Int { slides.count }
    
    //MARK: - Lifecycle
    init(rectFactory: RectFactoryProtocol) {
        self.rectFactory = rectFactory
    }
    
    //MARK: - Helper
    subscript(i: Int) -> Rectable? {
        (0..<slides.count) ~= i ? slides[i] : nil
    }
    mutating func makeRect(by type: Rectable.Type, photo: Data? = nil) -> Rectable {
        let newRect = rectFactory.make(by: type, photo: photo)
        slides.append(newRect)
        return newRect
    }
    
    mutating func changeAlpha(to alpha: Int) {
        selectedRect?.alpha = alpha
    }
    
    mutating func changeColor(to color: SKColor) {
        guard var rect = selectedRect as? Colorful else { return }
        rect.color = color
    }
    
    mutating func tapped(at point: SKPoint) {
        selectedRect = slides.first(where: { $0.contains(point: point) })
    }
}
