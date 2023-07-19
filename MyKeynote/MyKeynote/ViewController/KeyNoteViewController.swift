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
    private let canvasView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let backgroundView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    private let controlStackView = ControlStackView()
    //MARK: - Property
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        let factory = RectFactory(idService: IDService.shared, randomNumberGenerator: SystemRandomNumberGenerator())
        
        (0..<4).forEach { i in
            Logger.rectModel.log(level: .debug, "Rect\(i) \(factory.makeSquare().description)")
    override func loadView() {
        super.loadView()
        [backgroundView, canvasView, controlStackView].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = .darkGray
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        configureFrame()
    }
    //MARK: - Helper
    private func configureFrame() {
        let safeRect = view.safeAreaLayoutGuide.layoutFrame
        
        let canvasWidth = safeRect.width - Constant.sideWidth * 2
        let canvasHeight = (canvasWidth * 3.0 / 4.0)

        canvasView.frame = CGRect(x: Constant.sideWidth,
                                  y: safeRect.minY + (view.frame.height - safeRect.minY - canvasHeight) / 2,
                                  width: canvasWidth,
                                  height: canvasWidth * 3.0 / 4.0)
        
        backgroundView.frame = CGRect(x: safeRect.minX,
                                      y: safeRect.minY,
                                      width: safeRect.width,
                                      height: safeRect.minY + safeRect.height)
        
        controlStackView.frame = CGRect(x: canvasView.frame.maxX,
                                        y: safeRect.minY,
                                        width: Constant.sideWidth,
                                        height: view.frame.height - safeRect.minY)
    }
}

