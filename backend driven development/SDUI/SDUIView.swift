//
//  SDUIView.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 10/03/22.
//

import UIKit

class SDUIView: UIView {
    let widgets: [Widget]
    let visitor: Visitor
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    let contentView: UIStackView = {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.spacing = 8
        return contentView
    }()
    
    init(visitor: Visitor, widgets: [Widget]) {
        self.visitor = visitor
        self.widgets = widgets
        
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBackground
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        addWidgetsAsViews(to: contentView)
    }
    
    private func addWidgetsAsViews(to contentView: UIStackView) {
        self.widgets.forEach {
            let view = $0.createView(visitor: self.visitor)
            contentView.addArrangedSubview(view)
        }
    }
    
    func setupConstraints() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
    }
    
    private func setupScrollViewConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func setupContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}
