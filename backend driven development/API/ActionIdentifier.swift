//
//  ActionIdentifier.swift
//  backend driven development
//
//  Created by Renato Noronha Máximo on 24/03/22.
//

import UIKit

enum ActionIdentifier: String, Decodable {
    case home = "HOME"
    case serverSideScreen = "SCREEN_SERVER"
    case frontSideScreenA = "SCREEN_B_FRONT"
    case frontSideScreenB = "SCREEN_A_FRONT"

    var metatype: Action.Type {
        switch self {
        case .home:
            return HomeAction.self
        case .serverSideScreen:
            return ServerSideScreenAction.self
        case .frontSideScreenA:
            return FrontSideScreenAAction.self
        case .frontSideScreenB:
            return FrontSideScreenBAction.self
        }
    }
}


//MARK: - Examples of actions that will build a screen using server data

struct HomeAction: Action {
    func scene() -> UIViewController {
        return SDUIViewController(url: "home", title: "Home")
    }
}

struct ServerSideScreenAction: Action {
    let title: String
    let url: String

    func scene() -> UIViewController {
        return SDUIViewController(url: url, title: title)
    }
}


//MARK: - Examples of actions that will build a screen without using server data

struct FrontSideScreenAAction: Action {
    let title: String

    func scene() -> UIViewController {
        let viewController = UIViewController()
        // ...
        return viewController
    }
}

struct FrontSideScreenBAction: Action {
    let title: String

    func scene() -> UIViewController {
        let viewController = UIViewController()
        // ...
        return viewController
    }
}
