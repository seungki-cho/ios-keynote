//
//  CanvasView.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/24.
//

import UIKit

protocol CanvasViewDelegate: AnyObject {
    func canvasTapped(at point: CGPoint)
}

class CanvasView: UIView { 
    // MARK: - UI properties
    private var slide: UIView!
    
    // MARK: - Properties
    weak var delegate: CanvasViewDelegate?
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureEvent()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureEvent()
        backgroundColor = .white
    }
    // MARK: - Helpers
    private func configureEvent() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(canvasTapped(sender:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func canvasTapped(sender: UITapGestureRecognizer) {
        delegate?.canvasTapped(at: sender.location(in: self))
    }
    
    func makeRectable(_ rectable: Rectable, color: UIColor? = nil) {
        let (width, height) = (rectable.getWidth(), Double(rectable.height))
        slide = UIView(frame: CGRect(x: bounds.midX - width / 2,
                                     y: bounds.midY - height / 2,
                                     width: width,
                                     height: height))
        slide.backgroundColor = color
        tag = rectable.id.toInt
        addSubview(slide)
    }
    
    func changeSelection(to isSelected: Bool) {
        slide.isSelected = isSelected
    }
    
    func changeColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        slide.changeBackgroundColor(red: red, green: green, blue: blue)
    }
    
    func changeAlpha(to alpha: CGFloat) {
        slide.changeBackgroundAlpha(to: alpha)
    }
}
