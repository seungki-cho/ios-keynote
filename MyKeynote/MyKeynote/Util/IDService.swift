//
//  IDService.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class IDService {
    static let shared = IDService()
    
    var IDs: Set<String> = []
    
    private init() {}
}
