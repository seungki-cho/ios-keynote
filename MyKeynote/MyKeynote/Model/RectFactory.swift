//
//  RectFactory.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class RectFactory: RectFactoryProtocol {
    private let idService: IDServiceProtocol
    private var randomNumberGenerator: RandomNumberGenerator
    
    init(idService: IDServiceProtocol, randomNumberGenerator: RandomNumberGenerator) {
        self.idService = idService
        self.randomNumberGenerator = randomNumberGenerator
    }

    func makeSquare() -> Square {
        Square(id: idService.makeNewID(),
               height: Int.random(in: 100...300, using: &randomNumberGenerator),
               alpha: Int.random(in: 1...10, using: &randomNumberGenerator),
               color: SKColor.randomOne())
    }
}
