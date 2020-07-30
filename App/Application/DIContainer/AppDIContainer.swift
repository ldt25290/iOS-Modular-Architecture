//
//  DIContainer.swift
//  App
//
//  Created by Oleh Kudinov on 01.10.18.
//

import Networking
import Authentication
import MoviesSearch
import ChatModule

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Feature Modules
    func makeMoviesSearchModule(chatPresenter: ChatPresenter) -> MoviesSearch.Module {
        let dependencies = MoviesSearch.ModuleDependencies(apiDataTransferService: apiDataTransferService,
                                                           imageDataTransferService: imageDataTransferService,
                                                           chatPresenter: chatPresenter)
        return MoviesSearch.Module(dependencies: dependencies)
    }
  
  
    func makeChatModule() -> ChatModule.Module {
        let dependencies = ChatModule.ModuleDependencies(apiDataTransferService: apiDataTransferService,
                                                           imageDataTransferService: imageDataTransferService)
        return ChatModule.Module(dependencies: dependencies)
    }
    
    // MARK: - Network
    lazy var sessionManager = AuthNetworkSessionManager()
    lazy var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!,
                                          queryParameters: ["api_key": appConfiguration.apiKey,
                                                            "language": NSLocale.preferredLanguages.first ?? "en"])
        
        let apiDataNetwork = DefaultNetworkService(config: config,
                                                   sessionManager: sessionManager)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()
    lazy var imageDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.imagesBaseURL)!)
        let imagesDataNetwork = DefaultNetworkService(config: config,
                                                      sessionManager: sessionManager)
        return DefaultDataTransferService(with: imagesDataNetwork)
    }()
    
}

// MARK: - Authentication conformance to Networking Service Protocols
extension AuthNetworkRequest: NetworkCancellable {}
extension AuthNetworkSessionManager: NetworkSessionManager {
    public func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        return authRequest(request, completion: completion)
    }
}
