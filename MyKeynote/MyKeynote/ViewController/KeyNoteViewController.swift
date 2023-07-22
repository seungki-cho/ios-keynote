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
    private let makeRectButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        return button
    }()
    //MARK: - Property
    var slideManager: SlideManagerProtocol
    private var selectedRectTag: Int = -1
    
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
        controlStackView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(canvasTapped(sender:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        makeRectButton.addTarget(self, action: #selector(newSquareButtonTapped(_:)), for: .touchUpInside)
        bind()
    }
    
    private func bind() {
        slideManager.alphaChanged = { [weak self] rect in
            guard let self, let rect else { return }
            let view = findSubview(tag: IDService.toInt(rect.id))
            view?.alpha = CGFloat(rect.alpha)/10
        }
        
        slideManager.colorChanged = { [weak self] rect in 
            guard let self else { return }
            let view = findSubview(tag: IDService.toInt(rect.id))
            view?.backgroundColor = UIColor(skColor: rect.color, skAlpha: rect.alpha)
        }
        
        slideManager.selectedRectDidChanged = { [weak self] rect in
            guard let self else { return }
            let oldView = findSubview(tag: selectedRectTag)
            oldView?.isSelected = false
            selectedRectTag = -1
            guard let rect = rect else { return }
            let view = findSubview(tag: IDService.toInt(rect.id))
            view?.isSelected = true
            selectedRectTag = IDService.toInt(rect.id)
        }
    }
    @objc func newSquareButtonTapped(_ sender: UIButton!) {
        let square = slideManager.makeRect(by: Square.self)
        let newView = UIView(frame: CGRect(x: square.point.x,
                                           y: square.point.y,
                                           width: square.getWidth(),
                                           height: Double(square.height)))
        newView.backgroundColor = UIColor(skColor: square.color, skAlpha: square.alpha)
        newView.tag = IDService.toInt(square.id)
        canvasView.addSubview(newView)
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
    }
}

extension KeyNoteViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        var (red, green, blue): (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        viewController.selectedColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        slideManager.changeColor(for: "a", to: SKColor(red: UInt8(red * 255),
                                                       green: UInt8(green * 255),
                                                       blue: UInt8(blue * 255)))
    }
}
