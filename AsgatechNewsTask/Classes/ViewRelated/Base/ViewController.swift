//
//  ViewController.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - Base ViewController
//
/// For default implementations about on error or loading state
///
class ViewController: UIViewController {
    
    // MARK: - ViewModel + State Binding Helpers

    @discardableResult
    func bindLoadingState(to viewModel: ViewModel) -> ObservationToken {
        let type = progressType
        return viewModel.state.subscribe { [weak self] state in
            self?.shouldShowProgressView(state == .loading, type: type)
        }
    }
    
    @discardableResult
    func bindErrorState(to viewModel: ViewModel) -> ObservationToken {
        return viewModel.state.subscribe { [weak self] state in
            if case .failure(let error) = state {
                self?.showErrorAlert(error: error)
            }
        }
    }
}
