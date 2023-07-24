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
    private let canvasView = CanvasView()
    private let controlStackView = ControlStackView()
    private let backgroundView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    private let makeRectButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        return button
    }()
    //MARK: - Property
    var slideManager: SlideManagerProtocol
    private var selectedRectTag: Int?
    
    //MARK: - LifeCycle
    init(slideManager: SlideManagerProtocol) {
        self.slideManager = slideManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let rectFactory = RectFactory(idService: IDService.shared,
                                      randomNumberGenerator: SystemRandomNumberGenerator())
        self.slideManager = SlideManager(rectFactory: rectFactory)
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        [backgroundView, canvasView, controlStackView, makeRectButton].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = .darkGray
        configureEvent()
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
        
        makeRectButton.frame = CGRect(x: 0,
                                      y: safeRect.midY - 50,
                                      width: 100,
                                      height: 100)
    }
    
    private func configureEvent() {
        canvasView.delegate = self
        controlStackView.delegate = self
        bind()
    }
    
    private func bind() {
        slideManager.changed = { [weak self] rect in
            guard let self, let rect else { return }
            let view = findSubview(tag: IDService.toInt(rect.id))
            view?.changeBackgroundColor(rect.alpha, (rect as? Colorful)?.color)
            controlStackView.bind(rect.alpha, (rect as? Colorful)?.color)
        }
        
        slideManager.selectedRectDidChanged = { [weak self] rect in
            guard let self else { return }
            let oldView = findSubview(tag: selectedRectTag)
            oldView?.isSelected = false
            let view = findSubview(tag: IDService.toInt(rect?.id))
            view?.isSelected = true
            selectedRectTag = IDService.toInt(rect?.id)
            controlStackView.bind(rect?.alpha, (rect as? Colorful)?.color)
        }
    }
    
    private func findSubview(tag: Int?) -> UIView? {
        guard let tag else { return nil }
        return canvasView.viewWithTag(tag)
    }
}

extension KeyNoteViewController: CanvasViewDelegate {
    func canvasTapped(at point: CGPoint) {
        slideManager.tapped(at: SKPoint(x: point.x, y: point.y))
    }
}

extension KeyNoteViewController: ControlStackViewDelegate {
    func colorButtonTapped() {
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.supportsAlpha = false
        colorPickerViewController.delegate = self
        present(colorPickerViewController, animated: true)
    }
    
    func stepperValueChanged(to value: Double) {
        slideManager.changeAlpha(to: Int(value))
    }
}

extension KeyNoteViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        var (red, green, blue): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        viewController.selectedColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        slideManager.changeColor(to: SKColor(red: UInt8(red * 255),
                                             green: UInt8(green * 255),
                                             blue: UInt8(blue * 255)))
    }
}
