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
    func makeRect<T: Rectable>(by type: T.Type, photo: Data? = nil) -> T {
        let newRect = rectFactory.make(by: type, photo: photo)
        slides.append(newRect)
        return newRect
    }
    
        selectedRect?.alpha = alpha
        changed?(selectedRect)
    func changeAlpha(to alpha: Int) {
    }
    
        guard let rect = selectedRect as? Rect else { return }
    func changeColor(to color: SKColor) {
        rect.color = color
        changed?(rect)
    }
    
        let currentSlide = slides[currentSlideIndex]
        selectedRect = currentSlide.contains(point: point, where: center) ? currentSlide : nil
    func tapped(at point: SKPoint, center: SKPoint) {
    }
}
