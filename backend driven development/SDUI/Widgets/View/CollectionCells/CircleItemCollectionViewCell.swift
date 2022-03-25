//
//  CircleItemCollectionViewCell.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 17/03/22.
//

import UIKit

final class CircleItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "CircleItemCollectionViewCell"
    
    private let cellSize: CGSize = CGSize(width: 90.0, height: 114.0)
    private let imageSide: CGFloat = 90.0
    
    var imageBgColor: UIColor? {
        didSet {
            imageView.backgroundColor = imageBgColor
        }
    }
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private let imageView: UIStackView = {
        let image = UIStackView()
        image.clipsToBounds = true
        
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .darkGray
        label.text = "Image"
        
        image.addArrangedSubview(label)
        
        return image
    }()
    
    
    private let priceStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    let name: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.populateWithViews([imageView, priceStack])
        priceStack.populateWithViews([name])
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSide),
            imageView.widthAnchor.constraint(equalToConstant: imageSide),
            priceStack.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        imageView.layer.cornerRadius = imageSide/2.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension UIStackView {
    /// Inject an array of UIView into StackView
    func populateWithViews(_ array: [UIView]) {
        for item in self.arrangedSubviews {
            item.removeFromSuperview()
        }
        
        for view in array {
            self.addArrangedSubview(view)
        }
    }
}
