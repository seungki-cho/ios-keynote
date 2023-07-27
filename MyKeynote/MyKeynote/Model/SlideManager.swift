//
//  SlideManager.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

class SlideManager: SlideManagerProtocol {
    enum Notifications {
        static let selectedRectChanged = Notification.Name("selectedRectChanged")
        static let rectColorChanged = Notification.Name("rectColorChanged")
        static let slideAlphaChanged = Notification.Name("slideAlphaChanged")
        static let squareMade = Notification.Name("squareMade")
        static let tableIndexChanged = Notification.Name("tableIndexChanged")
    }
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
    
    func makeSquare() {
        let newRect = rectFactory.makeSquare()
        slides.append(newRect)
        
        currentTableIndex = count - 1
        NotificationCenter.default.post(name: SlideManager.Notifications.squareMade, object: self, userInfo: ["slide": newRect, "index": currentTableIndex])
    }
    
    func changeAlpha(to alpha: Int) {
        guard let index = currentTableIndex else { return }
        slides[index].alpha = alpha
        NotificationCenter.default.post(name: SlideManager.Notifications.slideAlphaChanged, object: self, userInfo: ["slide": slides[index]])
    }
    
    func changeColor(to color: SKColor) {
        guard let index = currentTableIndex,
              var rect = slides[index] as? Colorful else { return }
        rect.color = color
        NotificationCenter.default.post(name: SlideManager.Notifications.rectColorChanged, object: self, userInfo: ["rect": rect])
    }
    
    func tapped(at point: SKPoint, center: SKPoint) {
        guard let index = currentTableIndex else { return }
        let slide = slides[index]
        let selectedRect = slide.contains(point: point, where: center) ? slide : nil
        NotificationCenter.default.post(name: SlideManager.Notifications.selectedRectChanged, object: self, userInfo: ["selectedRect": selectedRect])
    }
    
    func changeTableIndex(to index: Int?) {
        currentTableIndex = index
        
        let slide = index != nil ? self[index!] : nil
        NotificationCenter.default.post(name: SlideManager.Notifications.tableIndexChanged, object: self, userInfo: ["id": slide?.id])
        NotificationCenter.default.post(name: SlideManager.Notifications.selectedRectChanged, object: self, userInfo: ["selectedRect": slide])
    }
}
