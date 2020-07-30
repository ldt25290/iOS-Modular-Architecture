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
    
  public init (apiDataTransferService: DataTransferService, imageDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
        self.imageDataTransferService = imageDataTransferService
    }
}

public struct Module {

    private let diContainer: DIContainer
    
    public init(dependencies: ModuleDependencies) {
        self.diContainer = DIContainer(dependencies: dependencies)
    }
    
    public func startChatFlow(in navigationController: UINavigationController, in viewController: UIViewController? = nil) {
        let flow = diContainer.makeChatFlowCoordinator(navigationController: navigationController)
        flow.start(viewController: viewController)
    }
  
}
