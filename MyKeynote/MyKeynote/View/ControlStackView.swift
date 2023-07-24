//
//  ControlStackView.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import UIKit

protocol ControlStackViewDelegate: AnyObject {
    func colorButtonTapped()
    func stepperValueChanged(to value: Double)
}

class ControlStackView: UIView {
    // MARK: - UI properties
    private let colorControlView = ColorControlView()
    private let alphaControlView = AlphaControlView()
    // MARK: - Properties
    weak var delegate: ControlStackViewDelegate?
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureFrame()
    }
    // MARK: - Helpers
    private func configureUI() {
        backgroundColor = .systemGray5
        [colorControlView, alphaControlView].forEach {
            addSubview($0)
        }
        colorControlView.delegate = self
        alphaControlView.delegate = self
    }
    
    func configureFrame() {
        let yMargin = 5.0
        colorControlView.frame = CGRect(x: 0,
                                        y: yMargin,
                                        width: frame.width,
                                        height: frame.width * 9 / 16)
        
        alphaControlView.frame = CGRect(x: 0,
                                        y: colorControlView.frame.maxY + yMargin,
                                        width: frame.width,
                                        height: frame.width * 9 / 16)
    }
    
    func bind(_ skAlpha: Int? = nil, _ color: SKColor? = nil) {
        alphaControlView.bind(skAlpha: skAlpha)
        colorControlView.bind(color)
    }
}

extension ControlStackView: ColorControlViewDelegate {
    func colorButtonTapped() {
        delegate?.colorButtonTapped()
    }
}

extension ControlStackView: AlphaControlViewDelegate {
    func stepperValueChanged(to value: Double) {
        delegate?.stepperValueChanged(to: value)
    }
}
