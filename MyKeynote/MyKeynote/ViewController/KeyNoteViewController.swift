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
        static let sideWidth = 175.0
        static let cellHeight = 95.0
        static let makeRectButtonHeight = 50.0
    }
    //MARK: - UI Property
    private let tableView = UITableView()
    private let canvasView = CanvasView()
    private let controlStackView = ControlStackView()
    private let makeSlideButton = {
        let button = UIButton()
        button.setTitle("( + )", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = .cyan
        button.tintColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(makeSlideButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    private let backgroundView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    //MARK: - Property
    var slideManager: SlideManagerProtocol
    
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
        [backgroundView, controlStackView, canvasView, tableView, makeSlideButton].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = .darkGray
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        configureFrame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let square = slideManager.makeRect(by: Square.self, photo: nil)
        canvasView.makeRectable(square, color: UIColor(skColor: square.color, skAlpha: square.alpha))

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
        
        controlStackView.frame = CGRect(x: safeRect.maxX - Constant.sideWidth,
                                        y: safeRect.minY,
                                        width: Constant.sideWidth,
                                        height: view.frame.height - safeRect.minY)
        
        tableView.frame = CGRect(x: 0,
                                 y: safeRect.minY,
                                 width: Constant.sideWidth,
                                 height: view.frame.height - safeRect.minY - Constant.makeRectButtonHeight)
        
        makeSlideButton.frame = CGRect(x: 0,
                                       y: tableView.frame.maxY,
                                       width: Constant.sideWidth,
                                       height: Constant.makeRectButtonHeight)
    }
    
    private func configureEvent() {
        canvasView.delegate = self
        controlStackView.delegate = self
        tableView.delegate = self
        tableView.register(SlideCell.self, forCellReuseIdentifier: SlideCell.identifier)
        bind()
    }
    
    private func bind() {
        NotificationCenter.default.addObserver(forName: .selectedRectChanged, object: nil, queue: nil, using: { [weak self] notification in
            guard let self,
                  let userInfo = notification.userInfo,
                  let selectedRect = userInfo["selectedRect"] as? Rectable else {
                self?.canvasView.changeSelection(to: false)
                self?.controlStackView.bind(alpha: nil)
                self?.controlStackView.bind(color: nil)
                return
            }
            canvasView.changeSelection(to: true)
            controlStackView.bind(alpha: selectedRect.alpha)
            controlStackView.bind(color: (selectedRect as? Colorful)?.color)
        })
        
        NotificationCenter.default.addObserver(forName: .slideAlphaChanged, object: nil, queue: nil, using: { [weak self] notification in
            guard let self,
                  let userInfo = notification.userInfo,
                  let rect = userInfo["slide"] as? Rectable else { return }
            
            let slide = findSlide(with: rect.id.toInt)
            slide?.changeAlpha(to: CGFloat(Double(rect.alpha) / 10))
        })
        
        NotificationCenter.default.addObserver(forName: .rectColorChanged, object: nil, queue: nil, using: { [weak self] notification in
            guard let self,
                  let userInfo = notification.userInfo,
                  let rect = userInfo["rect"] as? Rectable & Colorful else { return }
            
            let slide = findSlide(with: rect.id.toInt)
            let (red, green, blue) = rect.color.toDoubleRgb()
            slide?.changeColor(red: red, green: green, blue: blue)
        })
    }
    
    @objc func makeSlideButtonTapped(sender: UIButton!) {
        slideManager.makeRect(by: Square.self, photo: nil)
    }
}

extension KeyNoteViewController: UITableViewDelegate {
    
}

extension KeyNoteViewController: CanvasViewDelegate {
    func canvasTapped(at point: CGPoint) {
        slideManager.tapped(at: SKPoint(x: point.x,
                                        y: point.y),
                            center: SKPoint(x: canvasView.bounds.midX,
                                            y: canvasView.bounds.midY))
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
        
        let skColor = SKColor(red: UInt8(red * 255),
                              green: UInt8(green * 255),
                              blue: UInt8(blue * 255))
        slideManager.changeColor(to: skColor)
        controlStackView.bind(color: skColor)
    }
}
