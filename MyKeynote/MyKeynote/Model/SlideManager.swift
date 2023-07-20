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
    
    mutating func changeAlpha(for id: String, to alpha: Int) {
        guard var selectedRect = slides.first(where: { $0.id == id }) else { return }
        selectedRect.alpha = alpha
    }
    
    mutating func changeColor(for id: String, to color: SKColor) {
        guard var selectedRect = slides.first(where: { $0.id == id }) as? Colorful else { return }
        selectedRect.color = color
    }
}
