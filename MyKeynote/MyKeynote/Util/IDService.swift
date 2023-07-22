//
//  IDService.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

class IDService: IDServiceProtocol {
    static let shared = IDService()
    
    private var IDs: Set<String> = []
    
    private init() {}
        
    func makeNewID() -> String {
        let randomPool = "abcdefghijklmnopqrstuvwxyz0123456789".map{ String($0) }
        let randomArary = (0..<3).map { _ in (0..<3).map{ _ in randomPool[Int.random(in: 0..<randomPool.count)] }.joined() }
        let id = randomArary.joined(separator: "-")
        IDs.insert(IDs.contains(id) ? makeNewID() : id)
        return id
    }
    
    static func toInt(_ id: String) -> Int {
        id.hashValue
    }
}
