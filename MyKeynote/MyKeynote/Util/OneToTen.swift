//
//  OneToTen.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

@propertyWrapper
struct OneToTen {
    private var value: Int = 1
    var wrappedValue: Int {
        get { value }
        set {
            if newValue < 1 {
                self.value = 1
            } else if newValue > 10 {
                self.value = 10
            } else {
                self.value = newValue
            }
        }
    }
    
    init(wrappedValue initialValue: Int) {
        self.wrappedValue = initialValue
    }
}
