//
//  TitleWidgetView.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit

class BigImageWidgetView: UIStackView {
    private let widget: BigImageWidget
    
    let container: UIStackView = {
        return UIStackView()
    }()
    
    let image: UIStackView = {
        let image = UIStackView()
        image.layer.cornerRadius = 8
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
    
    init(widget: BigImageWidget) {
        self.widget = widget
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ViewCodable
extension BigImageWidgetView: ViewCodable {
    
    func setupHierarchy() {
        self.addArrangedSubview(container)
        container.addSubview(image)
    }
    
    func setupConstraints() {
        setupContainerConstraints()
        setupLabelConstraints()
    }
    
    private func setupContainerConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.useDefaultLayoutMargins()
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalTo: image.heightAnchor),
        ])
    }
    
    private func setupLabelConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = container.layoutMarginsGuide
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            image.heightAnchor.constraint(greaterThanOrEqualTo: image.widthAnchor),
            image.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor),
            image.bottomAnchor.constraint(greaterThanOrEqualTo: container.bottomAnchor),
        ])
    }
    
    func setupStyles() {
        image.backgroundColor = UIColor(hex: widget.color)
    }
}
