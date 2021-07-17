//
//  ViewModel.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - ViewModel - Base view model
//
class ViewModel {

    /// Current state subject
    ///
    var state = PublishSubject<State>()
}
