//
//  AlphaControlView.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/19.
//

import UIKit

protocol AlphaControlViewDelegate: AnyObject {
    func stepperValueChanged(to value: Double)
}

class AlphaControlView: UIView {
    enum Constant {
        static let xMargin = 10.0
        static let yMargin = 5.0
    }
    // MARK: - UI properties
    private let headerLabel = {
        let label = UILabel()
        label.text = "투명도"
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 100)
        return label
    }()
    private let alphaTextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20)
        textField.textAlignment = .right
        textField.backgroundColor = .white
        textField.layer.cornerRadius = Constant.xMargin
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.rightViewMode = .always
        textField.text = "0"
        textField.isEnabled = false
        textField.keyboardType = .numberPad
        return textField
    }()
    private let alphaStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.value = 10
        stepper.addTarget(nil, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        stepper.isEnabled = false
        return stepper
    }()
    // MARK: - Properties
    weak var delegate: AlphaControlViewDelegate?
    
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
        [headerLabel, alphaTextField, alphaStepper].forEach {
            addSubview($0)
        }
    }
    
    private func configureFrame() {
        headerLabel.frame = CGRect(x: Constant.xMargin,
                                   y: Constant.yMargin,
                                   width: frame.width / 3.0,
                                   height: frame.height / 2.0 - Constant.yMargin * 2)
        
        alphaTextField.frame = CGRect(x: Constant.xMargin,
                                      y: headerLabel.frame.maxY + Constant.yMargin,
                                      width: bounds.width / 4.0 ,
                                      height: frame.height / 2.0 - Constant.yMargin * 2)
        alphaStepper.frame.origin = CGPoint(x: alphaTextField.frame.maxX + Constant.xMargin,
                                            y: alphaTextField.frame.minY)
        alphaStepper.transform = CGAffineTransform(scaleX: 1.33, y: 1.36)
    }
    
    func bind(skAlpha: Int?) {
        guard let skAlpha else {
            alphaTextField.text = "0"
            alphaTextField.isEnabled = false
            alphaStepper.isEnabled = false
            return
        }
        alphaTextField.text = "\(skAlpha)"
        alphaTextField.isEnabled = true
        alphaStepper.value = Double(skAlpha)
        alphaStepper.isEnabled = true
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper!) {
        alphaTextField.text = "\(Int(sender.value))"
        delegate?.stepperValueChanged(to: sender.value)
    }
}
