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
               color: SKColor(red: UInt8.random(in: 0...255, using: &randomNumberGenerator),
                              green: UInt8.random(in: 0...255, using: &randomNumberGenerator),
                              blue: UInt8.random(in: 0...255, using: &randomNumberGenerator),
                              alpha: Int.random(in: 0...10, using: &randomNumberGenerator)),
               height: Int.random(in: 100...500, using: &randomNumberGenerator)
        )
    }
}
