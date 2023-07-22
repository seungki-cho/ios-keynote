//
//  RectFactory.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class RectFactory: RectFactoryProtocol {
    private var maxPoint = SKPoint(x: 500, y: 400)
    
    private let idService: IDServiceProtocol
    private var randomNumberGenerator: RandomNumberGenerator
    
    init(idService: IDServiceProtocol, randomNumberGenerator: RandomNumberGenerator) {
        self.idService = idService
        self.randomNumberGenerator = randomNumberGenerator
    }
    
    func changeMaxPoint(_ point: SKPoint) {
        guard point.x > 0 && point.y > 0 else { return }
        maxPoint = point
    }
    
    func make<T: Rectable>(by type: T.Type, photo: Data? = nil) -> T {
        type.init(id: idService.makeNewID(),
                  point: SKPoint(x: Double.random(in: 0...(maxPoint.x), using: &randomNumberGenerator),
                                 y: Double.random(in: 0...(maxPoint.y), using: &randomNumberGenerator)),
                  height: Int.random(in: 100...300, using: &randomNumberGenerator),
                  alpha: Int.random(in: 1...10, using: &randomNumberGenerator),
                  color: SKColor.randomOne(),
                  photo: photo)
    }
}
