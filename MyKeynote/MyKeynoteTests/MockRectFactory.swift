//
//  MockRectFactory.swift
//  MyKeynoteTests
//
//  Created by 조승기 on 2023/07/22.
//

import Foundation

class MockRectFactory: RectFactoryProtocol {
    func changeMaxPoint(_ point: SKPoint) {
        
    }
    
    func make<T>(by type: T.Type, photo: Data?) -> T where T : Rectable {
        T.init(id: "x:100, y:100, height:100, alpha:5, color:122,122,122",
               point: SKPoint(x: 100, y: 100),
               height: 100,
               alpha: 5,
               color: SKColor(red: 122, green: 122, blue: 122),
               photo: photo)
    }
}
