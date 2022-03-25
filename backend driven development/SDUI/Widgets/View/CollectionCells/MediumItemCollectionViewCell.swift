//
//  MediumItemCollectionViewCell.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 17/03/22.
//

import UIKit

final class MediumItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "MediumItemCollectionViewCell"
    var imageSize: CGSize = CGSize(width: 100, height: 100)
    
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
        image.backgroundColor = .orange
        image.layer.cornerRadius = 4
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.populateWithViews([imageView])
        contentView.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
        ])
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
