//
//  KeyNoteViewController.swift
//  MyKeynote
//
//  Created by cho seungki on 2023/07/17.
//

import UIKit
import os

class KeyNoteViewController: UIViewController {
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

