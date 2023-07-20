//
//  RectFactory.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class RectFactory: RectFactoryProtocol {
    private var maxPoint = SKPoint(x: 0, y: 0)
    
    private let idService: IDServiceProtocol
    private var randomNumberGenerator: RandomNumberGenerator
    
    init(idService: IDServiceProtocol, randomNumberGenerator: RandomNumberGenerator) {
        self.idService = idService
        self.randomNumberGenerator = randomNumberGenerator
    }
    
    func make(by type: Rect.Type, photo: Data? = nil) -> Rect {
    func changeMaxPoint(_ point: SKPoint) {
        guard point.x > 0 && point.y > 0 else { return }
        maxPoint = point
    }
        type.init(id: idService.makeNewID(),
                  height: Int.random(in: 100...500, using: &randomNumberGenerator),
                  alpha: Int.random(in: 0...10, using: &randomNumberGenerator),
                  color: SKColor.randomOne(),
                  photo: nil)
    }
}
