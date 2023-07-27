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
    private var currentTableIndex: Int?
    var count: Int { slides.count }
    
    //MARK: - Lifecycle
    init(rectFactory: RectFactoryProtocol) {
        self.rectFactory = rectFactory
    }
    
    //MARK: - Helper
    subscript(i: Int) -> Rectable? {
        (0..<slides.count) ~= i ? slides[i] : nil
    }
    
    func makeRect<T: Rectable>(by type: T.Type, photo: Data? = nil) {
        let newRect = rectFactory.make(by: type, photo: photo)
        slides.append(newRect)
        
        currentTableIndex = count - 1
        NotificationCenter.default.post(name: .squareMade, object: self, userInfo: ["slide": newRect, "index": currentTableIndex])
    }
    
    func changeAlpha(to alpha: Int) {
        guard let index = currentTableIndex else { return }
        slides[index].alpha = alpha
        NotificationCenter.default.post(name: .slideAlphaChanged, object: self, userInfo: ["slide": slides[index]])
    }
    
    func changeColor(to color: SKColor) {
        guard let index = currentTableIndex,
              var rect = slides[index] as? Colorful else { return }
        rect.color = color
        NotificationCenter.default.post(name: .rectColorChanged, object: self, userInfo: ["rect": rect])
    }
    
    func tapped(at point: SKPoint, center: SKPoint) {
        guard let index = currentTableIndex else { return }
        let slide = slides[index]
        let selectedRect = slide.contains(point: point, where: center) ? slide : nil
        NotificationCenter.default.post(name: .selectedRectChanged, object: self, userInfo: ["selectedRect": selectedRect])
    }
    
    func changeTableIndex(to index: Int?) {
        currentTableIndex = index
        
        let slide = index != nil ? self[index!] : nil
        NotificationCenter.default.post(name: .tableIndexChanged, object: self, userInfo: ["id": slide?.id])
        NotificationCenter.default.post(name: .selectedRectChanged, object: self, userInfo: ["selectedRect": slide])
    }
}
