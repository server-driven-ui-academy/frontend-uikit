//
//  WidgetIdentifier.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 24/03/22.
//

import Foundation

enum WidgetIdentifier: String, Decodable {
    case sectionTitle = "SECTION_TITLE"
    case banner = "BANNER"
    case list = "LIST"
    case collection = "RECTANGLE_COLLECTION"
    case circleCollection = "CIRCLE_COLLECTION"
    case grid = "GRID"
    case bigImage = "BIG_IMAGE"
    
    // new case to add a new widget
    
    var metatype: Widget.Type {
        switch self {
        case .sectionTitle:
            return TitleWidget.self
        case .banner:
            return BannerWidget.self
        case .list:
            return ListWidget.self
        case .collection:
            return RectangleCollectionWidget.self
        case .circleCollection:
            return CircleCollectionWidget.self
        case .grid:
            return GridWidget.self
        case .bigImage:
            return BigImageWidget.self
            
        // new case to add a new widget
        }
    }
}
