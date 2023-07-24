//
//  UIView+.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/21.
//

import UIKit

extension UIView {
    var isSelected: Bool {
        get {
            self.layer.borderWidth != 0
        }
        set {
            self.layer.borderWidth = newValue ? 3 : 0
            self.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    func changeBackgroundColor(_ alpha: Int? = nil, _ skColor: SKColor? = nil) {
        guard let skColor, let alpha else {
            var alpha: CGFloat = 0.0
            self.backgroundColor?.getRed(nil, green: nil, blue: nil, alpha: &alpha)
            self.backgroundColor = UIColor.white.withAlphaComponent(alpha)
            return
        }
        self.backgroundColor = UIColor(skColor: skColor, skAlpha: alpha)
    }
}
