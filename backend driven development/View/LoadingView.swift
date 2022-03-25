//
//  LoadingView.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 13/03/22.
//

import UIKit

class LoadingView: UIView {
    let content: UIStackView = {
        let contentView = UIStackView()
        return contentView
    }()
    
    let loading: UILabel = {
        let loading = UILabel()
        loading.text = "Loading..."
        loading.textColor = .gray
        loading.font = .boldSystemFont(ofSize: 22)
        loading.textAlignment = .center
        
        return loading
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(content)
        content.addArrangedSubview(loading)
        
        backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = true
        content.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            content.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            content.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            content.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
