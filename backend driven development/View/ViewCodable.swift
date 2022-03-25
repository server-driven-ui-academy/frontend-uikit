//
//  ViewCodable.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 24/03/22.
//

import Foundation

protocol ViewCodable {
    func setupViews()
    
    func setupHierarchy()
    func setupConstraints()
    func setupStyles()
    func setupGestures()
}

//MARK: - Default implementations
extension ViewCodable {
    
    func setupViews() {
        setupHierarchy()
        setupConstraints()
        setupStyles()
        setupGestures()
    }
    
    func setupConstraints() { }
    
    func setupStyles() { }
    
    func setupGestures() { }
}
