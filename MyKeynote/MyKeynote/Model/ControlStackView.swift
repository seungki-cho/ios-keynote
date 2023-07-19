//
//  ControlStackView.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import UIKit

class ControlStackView: UIView {
    // MARK: - UI properties
    private let colorControlView = ColorControlView()
    private let alphaControlView = AlphaControlView()
    // MARK: - Properties
    
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
        [colorControlView, alphaControlView].forEach {
            addSubview($0)
        }
        backgroundColor = .systemGray5
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
}
