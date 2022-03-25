//
//  SDUIViewController.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 09/03/22.
//

import UIKit

protocol ActionDelegate {
    func handleAction(action: AnyAction)
}

class SDUIViewController: UIViewController {
    var refreshControl: UIRefreshControl?
    let url: String
    
    //MARK: - Views
    let content: UIStackView = {
        return UIStackView()
    }()
    
    let loading: LoadingView = {
        return LoadingView()
    }()
    
    init(url: String, title: String = "") {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = content
        self.view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateContent(to: loading)
        
        reloadServerUI()
    }
    
    private func reloadServerUI() {
        // FakeAPI uses the data from the JSON files in API/'Fake Responses'
//        FakeAPI.call(endpoint: self.url, model: ServerUIResponse.self) { serverUIResponse in
//            self.handleServerUIResponse(serverUIResponse)
//        }
        
        // API request the data to the backend running in localhost:5001
        API.call(endpoint: self.url, model: ServerUIResponse.self) { serverUIResponse in
            self.handleServerUIResponse(serverUIResponse)
        }
    }
    
    private func handleServerUIResponse(_ response: ServerUIResponse) {
        let contentView = SDUIView(visitor: self, widgets: response.widgets)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        contentView.scrollView.addSubview(refreshControl)
        
        updateContent(to: contentView)
        self.refreshControl?.endRefreshing()
        
        self.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
        updateContent(to: loading)
        
        self.reloadServerUI()
    }
    
    private func updateContent(to view: UIView) {
        content.removeAllSubviews()
        content.addArrangedSubview(view)
    }
}

//MARK: - Action Delegate
extension SDUIViewController: ActionDelegate {
    func handleAction(action: AnyAction) {
        if let nextScene = action.action?.scene() {
            self.navigationController?.pushViewController(nextScene, animated: true)
        }
    }
}

//MARK: - Visitor
extension SDUIViewController: Visitor {
    func visit(widget: TitleWidget) -> UIView {
        return TitleWidgetView(widget: widget)
    }
    
    func visit(widget: BannerWidget) -> UIView {
        return BannerWidgetView(widget: widget, delegate: self)
    }
    
    func visit(widget: ListWidget) -> UIView {
        return ListWidgetView(widget: widget, delegate: self)
    }
    
    func visit(widget: RectangleCollectionWidget) -> UIView {
        return RectangleCollectionWidgetView(widget: widget, delegate: self)
    }
    
    func visit(widget: CircleCollectionWidget) -> UIView {
        return CircleCollectionWidgetView(widget: widget, delegate: self)
    }
    
    func visit(widget: GridWidget) -> UIView {
        return GridWidgetView(widget: widget, delegate: self)
    }
    
    func visit(widget: BigImageWidget) -> UIView {
        return BigImageWidgetView(widget: widget)
    }
    
    // implement new visit to add a new widget
}

protocol Visitor {
    func visit(widget: TitleWidget) -> UIView
    func visit(widget: BannerWidget) -> UIView
    func visit(widget: ListWidget) -> UIView
    func visit(widget: RectangleCollectionWidget) -> UIView
    func visit(widget: CircleCollectionWidget) -> UIView
    func visit(widget: GridWidget) -> UIView
    func visit(widget: BigImageWidget) -> UIView
    
    // declare new visit to add a new widget
}

fileprivate extension UIView {
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
