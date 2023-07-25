//
//  SKID.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/24.
//

import Foundation

struct SKID {
    var id: String
    
    var toInt: Int { id.hashValue }
}

extension SKID: Equatable {
    static func == (lhs: SKID, rhs: SKID) -> Bool {
        lhs.id == rhs.id
    }
}

extension SKID: Hashable {
    var hashValue: Int { id.hashValue }
}
