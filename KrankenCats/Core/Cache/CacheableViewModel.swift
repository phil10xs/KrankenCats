//
//  CacheableViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 01/02/2025.
//

import Foundation

// MARK: - Base View Model
class CacheableViewModel: ObservableObject {
    @Published var hasError = false
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var viewState: ViewState?
    
    let networkingManager: NetworkingManagerImpl
    let cacheManager: CacheManager
    
    var isLoading: Bool { viewState == .loading }
    var isFetching: Bool { viewState == .fetching }
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared,
         cacheManager: CacheManager = .shared) {
        self.networkingManager = networkingManager
        self.cacheManager = cacheManager
    }
    
    func handleError(_ error: Error) {
        self.hasError = true
        if let networkingError = error as? NetworkingManager.NetworkingError {
            self.error = networkingError
        } else {
            self.error = .custom(error: error)
        }
    }
}

