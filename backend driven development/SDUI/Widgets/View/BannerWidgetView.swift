//
//  BannerWidgetView.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit

class BannerWidgetView: UIStackView {
    private let widget: BannerWidget
    private let delegate: ActionDelegate
    
    //MARK: - Views
    private let container: UIView = {
        return UIView()
    }()
    
    private let banner: UIStackView = {
        let banner = UIStackView()
        banner.layer.cornerRadius = 12
        
        return banner
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        return label
    }()
    
    
    init(widget: BannerWidget, delegate: ActionDelegate) {
        self.widget = widget
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ViewCodable
extension BannerWidgetView: ViewCodable {
    
    func setupHierarchy() {
        self.addArrangedSubview(container)
        container.addSubview(banner)
        banner.addArrangedSubview(label)
    }
    
    func setupConstraints() {
        setupContainerConstraints()
        setupBannerConstraints()
    }
    
    private func setupContainerConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.useDefaultLayoutMargins()
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 140),
        ])
    }
    
    private func setupBannerConstraints() {
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = container.layoutMarginsGuide
        NSLayoutConstraint.activate([
            banner.heightAnchor.constraint(equalToConstant: 140),
            banner.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
    }
    
    func setupStyles() {
        banner.backgroundColor = UIColor(hex: widget.color)
        
        label.text = widget.title
        label.textColor = UIColor(hex: widget.titleColor ?? "#000000")
    }
    
    func setupGestures() {
        setupActionHandler()
    }
    
    private func setupActionHandler() {
        if let action = widget.action {
            addBannerTapAction(action: action)
        }
    }
    
    private func addBannerTapAction(action: AnyAction) {
        let tapGesture = WidgetTapGesture(widgetAction: action, target: self, action: #selector(pressed(_:)))
        banner.addGestureRecognizer(tapGesture)
    }
    
    @objc private func pressed(_ sender: WidgetTapGesture) {
        self.delegate.handleAction(action: sender.widgetAction)
    }
}

private class WidgetTapGesture: UITapGestureRecognizer {
    let widgetAction: AnyAction
    
    init(widgetAction: AnyAction, target: Any?, action: Selector?) {
        self.widgetAction = widgetAction
        super.init(target: target, action: action)
    }
}
