//
//  KeyNoteViewController.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import UIKit
import os

class KeyNoteViewController: UIViewController {
    enum Constant {
        static let sideWidth = 200.0
    }
    //MARK: - UI Property
    
    //MARK: - Property
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        let factory = RectFactory(idService: IDService.shared, randomNumberGenerator: SystemRandomNumberGenerator())
        
        (0..<4).forEach { i in
            Logger.rectModel.log(level: .debug, "Rect\(i) \(factory.makeSquare().description)")
        }
    }
    //MARK: - Helper
}

