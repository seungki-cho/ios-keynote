//
//  SlideCell.swift
//  MyKeynote
//
//  Created by 조승기 on 2023/07/25.
//

import UIKit

class SlideCell: UITableViewCell {
    // MARK: - UI properties
    private let slideImageView = {
        let imageView = UIImageView(image: UIImage.rectangleInsetFilled)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .center
        return imageView
    }()
    private let indexLabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        return label
    }()
    // MARK: - Properties
    static let identifier = "SlideCell"
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        [slideImageView, indexLabel].forEach {
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            slideImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            slideImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            slideImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            slideImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 4 / 3),
            indexLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            indexLabel.trailingAnchor.constraint(equalTo: slideImageView.leadingAnchor, constant: -3),
            indexLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 4),
            indexLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    func changeIndex(to index: String) {
        indexLabel.text = index
    }
}
