//
//  TitleWidgetView.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit

class TitleWidgetView: UIStackView {
    private let widget: TitleWidget
    
    //MARK: - Views
    let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(widget: TitleWidget) {
        self.widget = widget
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ViewCodable
extension TitleWidgetView: ViewCodable {
    
    func setupHierarchy() {
        self.addArrangedSubview(container)
        container.addSubview(label)
    }
    
    func setupConstraints() {
        setupContainerConstraints()
        setupLabelConstraints()
    }
    
    private func setupContainerConstraints() {
        container.useDefaultLayoutMargins()
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    private func setupLabelConstraints() {
        let margins = container.layoutMarginsGuide
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 25),
            label.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            label.bottomAnchor.constraint(greaterThanOrEqualTo: container.bottomAnchor, constant: 4),
        ])
    }
    
    func setupStyles() {
        label.text = widget.title
    }
}
