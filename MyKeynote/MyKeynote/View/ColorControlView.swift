//
//  ColorControlView.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/18.
//

import UIKit

protocol ColorControlViewDelegate: AnyObject {
    func didTapColorButton()
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
        button.backgroundColor = .yellow
        button.layer.cornerRadius = Constant.yMargin
        button.setTitle("0xFFFFFF", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTapColorButton(_:)), for: .touchUpInside)
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
    
    @objc private func didTapColorButton(_ sender: UIButton!) {
        delegate?.didTapColorButton()
    }
}
