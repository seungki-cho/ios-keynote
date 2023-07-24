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
    var slides: [String: UIView] = [:]
    weak var delegate: CanvasViewDelegate?
    
    // MARK: - Lifecycles
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(frame: CGRect, rectable: Rectable, color: UIColor? = nil) {
        super.init(frame: frame)
        configureEvent()
        makeRectable(rectable, color: color)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureEvent()
    }
    // MARK: - Helpers
    func configureEvent() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(canvasTapped(sender:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func canvasTapped(sender: UITapGestureRecognizer) {
        delegate?.canvasTapped(at: sender.location(in: self))
    }
    
    private func makeRectable(_ rectable: Rectable, color: UIColor? = nil) {
        let (width, height) = (rectable.getWidth(), Double(rectable.height))
        let newView = UIView(frame: CGRect(x: bounds.midX - width / 2,
                                           y: bounds.midY - height / 2,
                                           width: width,
                                           height: height))
        newView.backgroundColor = color
        slides[rectable.id] = newView
        subviews.forEach { $0.isHidden = true }
        addSubview(newView)
    }
}
