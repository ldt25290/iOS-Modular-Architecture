//
//  MoviesSearchFlowCoordinator.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 03.03.19.
//

import UIKit

protocol MoviesSearchFlowCoordinatorDependencies  {
    func makeMoviesListViewController(closures: MoviesListViewModelClosures) -> MoviesListViewController
    func makeMoviesDetailsViewController(movie: Movie, closures: MovieDetailsViewModelClosures) -> UIViewController
    func makeMoviesQueriesSuggestionsListViewController(didSelect: @escaping MoviesQueryListViewModelDidSelectClosure) -> UIViewController
    func openChatModule(viewController: UIViewController)
}

class MoviesSearchFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: MoviesSearchFlowCoordinatorDependencies

    private weak var moviesListVC: MoviesListViewController?
    private weak var moviesQueriesSuggestionsVC: UIViewController?
    private weak var movieDetailVC: UIViewController?

    init(navigationController: UINavigationController,
         dependencies: MoviesSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        // Note: here we keep strong reference with closures, this way this flow do not need to be strong referenced
        let closures = MoviesListViewModelClosures(showMovieDetails: showMovieDetails,
                                                   showMovieQueriesSuggestions: showMovieQueriesSuggestions,
                                                   closeMovieQueriesSuggestions: closeMovieQueriesSuggestions)
        let vc = dependencies.makeMoviesListViewController(closures: closures)

        navigationController?.pushViewController(vc, animated: false)
        moviesListVC = vc
    }

    private func showMovieDetails(movie: Movie) {
        let closures = MovieDetailsViewModelClosures(openChatScreen: openChatModule)
        let vc = dependencies.makeMoviesDetailsViewController(movie: movie, closures: closures)
        movieDetailVC = vc
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showMovieQueriesSuggestions(didSelect: @escaping (MovieQuery) -> Void) {
        guard let moviesListViewController = moviesListVC, moviesQueriesSuggestionsVC == nil,
            let container = moviesListViewController.suggestionsListContainer else { return }

        let vc = dependencies.makeMoviesQueriesSuggestionsListViewController(didSelect: didSelect)

        moviesListViewController.add(child: vc, container: container)
        moviesQueriesSuggestionsVC = vc
        container.isHidden = false
    }

    private func closeMovieQueriesSuggestions() {
        moviesQueriesSuggestionsVC?.remove()
        moviesQueriesSuggestionsVC = nil
        moviesListVC?.suggestionsListContainer.isHidden = true
    }
  
    private func openChatModule() {
      guard let viewController = movieDetailVC else {
        return
      }
      dependencies.openChatModule(viewController: viewController)
    }
}
