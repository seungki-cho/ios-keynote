//
//  Logger+.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import Foundation
import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "seungki-cho.MyKeynote"
    static let rectModel = Logger(subsystem: subsystem, category: "RectModel")
}
