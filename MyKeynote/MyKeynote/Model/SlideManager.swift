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
    private var currentSlideIndex = 0
    private var selectedRect: Rectable? {
        willSet {
            selectedRectDidChanged?(newValue)
        }
    }
    var count: Int { slides.count }
    
    //MARK: - Output
    var selectedRectDidChanged: ((Rectable?) -> ())?
    var changed: ((Rectable?) -> ())?
    
    //MARK: - Lifecycle
    init(rectFactory: RectFactoryProtocol) {
        self.rectFactory = rectFactory
    }
    
    //MARK: - Helper
    subscript(i: Int) -> Rectable? {
        (0..<slides.count) ~= i ? slides[i] : nil
    }
    mutating func makeRect<T: Rectable>(by type: T.Type, photo: Data? = nil) -> T {
        let newRect = rectFactory.make(by: type, photo: photo)
        slides.append(newRect)
        return newRect
    }
    
    mutating func changeAlpha(to alpha: Int) {
        selectedRect?.alpha = alpha
        changed?(selectedRect)
    }
    
    mutating func changeColor(to color: SKColor) {
        guard let rect = selectedRect as? Rect else { return }
        rect.color = color
        changed?(rect)
    }
    
    mutating func tapped(at point: SKPoint) {
        selectedRect = slides.last(where: { $0.contains(point: point) })
    mutating func tapped(at point: SKPoint, center: SKPoint) {
        let currentSlide = slides[currentSlideIndex]
        selectedRect = currentSlide.contains(point: point, where: center) ? currentSlide : nil
    }
}
