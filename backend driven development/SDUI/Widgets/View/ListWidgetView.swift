//
//  ListWidgetView.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 14/03/22.
//

import UIKit


class ListWidgetView: UIStackView {
    private let widget: ListWidget
    private let delegate: ActionDelegate
    
    //MARK: - Views
    let container: UIView = {
        let container = UIView()
        return container
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        table.rowHeight = 45.0
        return table
    }()
    
    
    init(widget: ListWidget, delegate: ActionDelegate) {
        self.widget = widget
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        setupViews()
        
        table.dataSource = self
        table.delegate = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ViewCodable
extension ListWidgetView: ViewCodable {
    
    func setupHierarchy() {
        self.addArrangedSubview(container)
        container.addSubview(stack)
        stack.addArrangedSubview(table)
    }
    
    func setupConstraints() {
        let rowHeight = 45.0
        let totalHeight = rowHeight * CGFloat(widget.list.count)
        
        setupContainerConstraints(totalHeight)
        setupStackConstraints(totalHeight)
    }
    
    private func setupContainerConstraints(_ totalHeight: Double) {
        container.useDefaultLayoutMargins()
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: totalHeight),
        ])
    }
    
    private func setupStackConstraints(_ totalHeight: Double) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = container.layoutMarginsGuide
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: totalHeight),
            stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
    }
}

//MARK: - Table DataSource & Delegate
extension ListWidgetView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return widget.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(widget.list[indexPath.row].text)"
        cell.backgroundColor = UIColor(hex: widget.list[indexPath.row].color)
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
}
