//
//  OneToTen.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation

@propertyWrapper
struct OneToTen {
    private var value: Int = 0
    var wrappedValue: Int {
        get { value }
        set {
            if newValue < 0 {
                self.value = 0
            } else if newValue > 10 {
                self.value = 10
            } else {
                self.value = newValue
            }
        }
    }
    
    init(wrappedValue iniitalValue: Int) {
        self.wrappedValue = value
    }
}
