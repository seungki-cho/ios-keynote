//
//  RectFactoryProtocol.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

protocol RectFactoryProtocol {
    func changeMaxPoint(_ point: SKPoint)
    func make<T: Rectable>(by type: T.Type, photo: Data?) -> T
}
