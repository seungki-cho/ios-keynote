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
    
    func changeMaxPoint(_ point: SKPoint) {
        guard point.x > 0 && point.y > 0 else { return }
        maxPoint = point
    }
    
    func make(by type: Rectable.Type, photo: Data? = nil) -> Rectable {
        type.init(id: idService.makeNewID(),
                  point: SKPoint(x: Double.random(in: 0...(maxPoint.x-300), using: &randomNumberGenerator),
                                 y: Double.random(in: 0...(maxPoint.y-300), using: &randomNumberGenerator)),
                  height: Int.random(in: 100...300, using: &randomNumberGenerator),
                  alpha: Int.random(in: 0...10, using: &randomNumberGenerator),
                  color: SKColor.randomOne(),
                  photo: photo)
    }
}
