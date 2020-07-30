//
//  ChatFlowCoordinator.swift
//  ChatModule
//
//  Created by Duc Tran on 7/30/20.
//

protocol ChatFlowCoordinatorDependencies {
  func makeChatViewController() -> UIViewController
}

import Foundation

class ChatFlowCoordinator {
  private weak var navigationController: UINavigationController?
  private let dependencies: ChatFlowCoordinatorDependencies
  
  init(navigationController: UINavigationController,
       dependencies: ChatFlowCoordinatorDependencies) {
      self.navigationController = navigationController
      self.dependencies = dependencies
  }
  
  func start(viewController: UIViewController? = nil) {
    let vc = dependencies.makeChatViewController()
    guard let viewController = viewController else {
      self.navigationController?.pushViewController(vc, animated: true)
      return
    }
    viewController.present(vc, animated: true, completion: nil)
  }
}
