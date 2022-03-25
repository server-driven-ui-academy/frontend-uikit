//
//  GridWidgetView.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 17/03/22.
//

import UIKit

class GridWidgetView: UIStackView {
    private let widget: GridWidget
    private let delegate: ActionDelegate
    
    //MARK: - Views
    let container: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        return container
    }()
    
    let collection: UICollectionView = {
        let defaultInsets = UIView.getDefaultLayoutMargins()
        let sectionInsets = UIEdgeInsets(top: 0.0, left: defaultInsets.left, bottom: 0.0, right: defaultInsets.right)
        
        let minimumInteritemSpacing: CGFloat = 10.0
        let minimumLineSpacing: CGFloat = 10.0
        let hSide = (UIScreen.main.bounds.size.width - sectionInsets.left - sectionInsets.right - minimumInteritemSpacing)/2.0
        let vSide = (UIScreen.main.bounds.size.width - sectionInsets.top - sectionInsets.bottom - minimumLineSpacing)/2.0
        let itemSize = CGSize(width: hSide, height: vSide)

        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = itemSize
        viewLayout.minimumInteritemSpacing = CGFloat(minimumInteritemSpacing)
        viewLayout.minimumLineSpacing = CGFloat(minimumLineSpacing)
        viewLayout.sectionInset = sectionInsets
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.register(MediumItemCollectionViewCell.self, forCellWithReuseIdentifier: MediumItemCollectionViewCell.identifier)
        
        return collection
    }()
    
    init(widget: GridWidget, delegate: ActionDelegate) {
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
extension GridWidgetView: ViewCodable {
    
    func setupHierarchy() {
        container.addArrangedSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        self.addArrangedSubview(container)
    }
    
    func setupConstraints() {
        let sectionInsets = UIView.getDefaultLayoutMargins()
        
        let minimumLineSpacing: CGFloat = 10.0
        let vSide = (UIScreen.main.bounds.size.width - sectionInsets.top - sectionInsets.bottom - minimumLineSpacing)/2.0
        let e: CGFloat = CGFloat(widget.list.count)
        
        let numberOfLines = CGFloat(ceil(e/2.0))
        let stackHeight: CGFloat = minimumLineSpacing * CGFloat(numberOfLines-1) + vSide * numberOfLines + sectionInsets.top + sectionInsets.bottom
        

        if let collection = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            collection.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(greaterThanOrEqualToConstant: stackHeight),
        ])
    }
}

//MARK: - Collection DataSource & Delegate
extension GridWidgetView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return widget.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediumItemCollectionViewCell.identifier, for: indexPath) as! MediumItemCollectionViewCell
        
        let item = widget.list[indexPath.row]
        cell.imageBgColor = UIColor(hex: item.color)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            cell.imageSize = layout.itemSize
        }
        
        cell.setupConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = widget.list[indexPath.row]
        if let action = item.action {
            delegate.handleAction(action: action)
        }
    }
}
