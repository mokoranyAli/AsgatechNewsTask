//
//  RemoteError.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - RemoteError
//
/// This for handling connection error
///
enum RemoteError : String, Error {
    case noInternet = "Please check internet connection"
    case notFound = "No data found or page removed"
}
