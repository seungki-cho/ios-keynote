//
//  ColorControlView.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import UIKit

protocol ColorControlViewDelegate: AnyObject {
    func colorButtonTapped()
}

class ColorControlView: UIView {
    enum Constant {
        static let xMargin = 10.0
        static let yMargin = 5.0
    }
    // MARK: - UI properties
    private let headerLabel = {
        let label = UILabel()
        label.text = "배경색"
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 100)
        return label
    }()
    private let colorButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = Constant.yMargin
        button.setTitle("0x000000", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("0x000000", for: .disabled)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.isEnabled = false
        button.addTarget(nil, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    // MARK: - Property
    weak var delegate: ColorControlViewDelegate?
    
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
        [headerLabel, colorButton].forEach {
            addSubview($0)
        }
    }
    
    private func configureFrame() {
        headerLabel.frame = CGRect(x: Constant.xMargin,
                                   y: Constant.yMargin,
                                   width: frame.width / 3.0,
                                   height: frame.height / 2.0 - Constant.yMargin * 2)
        
        colorButton.frame = CGRect(x: Constant.xMargin,
                                   y: Constant.yMargin * 2 + headerLabel.frame.height,
                                   width: frame.width - Constant.xMargin * 2,
                                   height: frame.height / 2.0 - Constant.yMargin * 2)
    }
    
    @objc private func colorButtonTapped(_ sender: UIButton!) {
        delegate?.colorButtonTapped()
    }
    
    func changeColor(to color: SKColor?) {
        guard let color else {
            colorButton.isEnabled = false
            colorButton.backgroundColor = UIColor.white
            return
        }
        colorButton.isEnabled = true
        colorButton.setTitle(color.toHex(), for: .normal)
        colorButton.setTitleColor(UIColor(skColor: color.complementaryColor(), skAlpha: 10), for: .normal)
        colorButton.backgroundColor = UIColor(skColor: color, skAlpha: 10)
    }
}
