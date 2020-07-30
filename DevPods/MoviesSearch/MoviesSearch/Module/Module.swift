//
//  MoviesSearchModule.swift
//  MoviesSearch
//
//  Created by Oleh Kudinov on 23.12.19.
//

import UIKit
import Networking

public struct ModuleDependencies {
    let apiDataTransferService: DataTransferService
    let imageDataTransferService: DataTransferService
    weak var chatPresenter: ChatPresenter?
    
  public init (apiDataTransferService: DataTransferService, imageDataTransferService: DataTransferService, chatPresenter: ChatPresenter? = nil) {
        self.apiDataTransferService = apiDataTransferService
        self.imageDataTransferService = imageDataTransferService
        self.chatPresenter = chatPresenter
    }
}

public struct Module {

    private let diContainer: DIContainer
    
    public init(dependencies: ModuleDependencies) {
        self.diContainer = DIContainer(dependencies: dependencies)
    }
    
    public func startMoviesSearchFlow(in navigationController: UINavigationController) {
        let flow = diContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}

// Note: We can create ChatPresenter Interface and add it to ModuleDependencies if we want to delegate
// Chat feature to App and avoid dependency on Chat module from this module(same can be done by using closure)
public protocol ChatPresenter: AnyObject{
    func openChatForUser(inView: UIViewController)
}
