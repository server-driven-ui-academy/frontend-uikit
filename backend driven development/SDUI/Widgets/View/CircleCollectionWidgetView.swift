//
//  CircleCollectionWidgetView.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit

class CircleCollectionWidgetView: UIStackView {
    private let widget: CircleCollectionWidget
    private let delegate: ActionDelegate
    
    //MARK: - Views
    let scroll: UIScrollView = {
        return UIScrollView()
    }()
    
    let scrollContent: UIStackView = {
        let content = UIStackView()
        content.axis = .horizontal
        return content
    }()
    
    let collection: UICollectionView = {
        let itemSize = CGSize(width: 90, height: 114)
        let minimumInteritemSpacing: CGFloat = 20.0
        
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = itemSize
        viewLayout.minimumInteritemSpacing = CGFloat(minimumInteritemSpacing)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.register(CircleItemCollectionViewCell.self, forCellWithReuseIdentifier: CircleItemCollectionViewCell.identifier)
        
        return collection
    }()
    
    init(widget: CircleCollectionWidget, delegate: ActionDelegate) {
        self.widget = widget
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        setupViews()
        
        collection.dataSource = self
        collection.delegate = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - ViewCodable
extension CircleCollectionWidgetView: ViewCodable {
    
    func setupHierarchy() {
        self.addArrangedSubview(scroll)
        scroll.addSubview(scrollContent)
        scrollContent.addArrangedSubview(collection)
    }
    
    func setupConstraints() {
        setupScrollContentConstraints()
    }
    
    fileprivate func setupScrollContentConstraints() {
        let defaultMargins = UIView.getDefaultLayoutMargins()
        
        let itemSize = CGSize(width: 90, height: 114)
        let minimumInteritemSpacing: CGFloat = 20.0
        let e = widget.list.count
        let stackWidth: CGFloat = minimumInteritemSpacing * CGFloat(e-1) + itemSize.width * CGFloat(e)
        
        let bottomInset:CGFloat = 8.0
        
        scrollContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollContent.heightAnchor.constraint(greaterThanOrEqualToConstant: itemSize.height),
            scrollContent.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: -defaultMargins.right),
            scrollContent.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: defaultMargins.left),
            scrollContent.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.heightAnchor, constant: -bottomInset),
            scrollContent.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            scrollContent.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            scrollContent.widthAnchor.constraint(greaterThanOrEqualToConstant: stackWidth),
        ])
    }
}

//MARK: - Collection DataSource & Delegate
extension CircleCollectionWidgetView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return widget.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleItemCollectionViewCell.identifier, for: indexPath) as! CircleItemCollectionViewCell
        let item = widget.list[indexPath.row]
        cell.imageBgColor = UIColor(hex: item.color)
        cell.name.text = item.text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = widget.list[indexPath.row]
        if let action = item.action {
            delegate.handleAction(action: action)
        }
    }
}

