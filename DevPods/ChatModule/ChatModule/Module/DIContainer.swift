//
//  DIContainer.swift
//  App
//
//  Created by Oleh Kudinov on 03.03.19.
//

import UIKit

final class DIContainer: ChatFlowCoordinatorDependencies {
  
    private let dependencies: ModuleDependencies

    
    init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }
    
  
    func makeChatViewController() -> UIViewController {
       return ChatViewController.create()
    }
    

    // MARK: - Flow Coordinators
    func makeChatFlowCoordinator(navigationController: UINavigationController) -> ChatFlowCoordinator {
        return ChatFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
  
}
