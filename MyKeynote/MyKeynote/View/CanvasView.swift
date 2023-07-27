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
    // MARK: - Properties
    weak var delegate: CanvasViewDelegate?
    private var slides: [SKID: UIView] = [:]
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureEvent()
        backgroundColor = .white
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureEvent()
        backgroundColor = .white
        isHidden = true
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
        selectSlide(by: rectable.id)
        select(by: rectable.id, to: true)
    }
    
    func select(by id: SKID, to isSelected: Bool) {
        slides[id]?.isSelected = isSelected
    }
    
    func deselect() {
        slides.values.forEach { $0.isSelected = false }
    }
    
    func changeColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        slide.changeBackgroundColor(red: red, green: green, blue: blue)
    func selectSlide(by id: SKID) {
        isHidden = false
        subviews.forEach { $0.isHidden = true }
        slides[id]?.isHidden = false
    }
    
    func changeAlpha(to alpha: CGFloat) {
        slide.changeBackgroundAlpha(to: alpha)
    func deselectSlide() {
        self.isHidden = true
        subviews.forEach { $0.isHidden = true }
    }
}
