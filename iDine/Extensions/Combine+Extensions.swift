//
//  Combine+Extensions.swift
//  iDine
//
//  Created by Michael Long on 10/26/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import Foundation
import Combine

/// Error extension allows simplifyied handling of completion error results
///
///    .sink(receiveCompletion: { completion in
///        message = try? completion.error().localizedDescription
///    }, receiveValue: { (result: PostmanEchoTimeStampCheckResponse) in
///        data = result
///    })
///
extension Subscribers.Completion {
    private enum ErrorFunctionThrowsError: Error { case error }
    func error() throws -> Failure {
        if case let .failure(error) = self {
            return error
        }
        throw ErrorFunctionThrowsError.error
    }
}


/// Typealias of Set<AnyCancellable> for easier code entry
typealias Subscriptions = Set<AnyCancellable>


/// Collect extension allows SwftUI-like collection of mutliple subscriptions into Set<AnyCancellable> w/o .store(in: &subscriptions) for each.
/// Better than standard variadic insert as comma separator not needed between subscriptions.
///
///    subscriptions.collect {
///        somePublisher
///           .sink(receiveValue: { print($0) })
///        somePublisher
///           .sink(receiveValue: { print($0) })
///    }
///
extension Set where Element == AnyCancellable {
    mutating func collect(@CancelBuilder _ cancellables: () -> [AnyCancellable]) {
        self.formUnion(cancellables())
    }
    @_functionBuilder
    struct CancelBuilder {
        static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            cancellables
        }
    }
}

//extension Set where Element == AnyCancellable {
//    mutating func insert(_ cancellables: AnyCancellable?...) {
//        self.formUnion(cancellables.compactMap { $0 })
//    }
//}
