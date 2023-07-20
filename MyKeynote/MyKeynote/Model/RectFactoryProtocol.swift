//
//  RectFactoryProtocol.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import Foundation

protocol RectFactoryProtocol {
    func make(by type: Rect.Type, photo: Data?) -> Rect
}
