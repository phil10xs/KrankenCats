//
//  BreedViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import Foundation

final class BreedsViewModel: ObservableObject {    
    
    // MARK: - Properties
    
    @Published private(set) var breedsResponse: BreedsResponse?
    
    @Published var hasError = false
    
    @Published private(set) var error: NetworkingManager.NetworkingError?
    
    @Published private(set) var viewState: ViewState?
    
    private(set) var page = 0
    
    private let networkingManager: NetworkingManagerImpl!
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    // MARK: - Initializer
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    // MARK: - Internal Methods
    
    @MainActor
    internal func fetchCatBreeds() async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .breeds(page: page),
                                                               type: [Breed].self)
            self.breedsResponse = BreedsResponse(breeds: response)
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    internal func fetchNextSetOfCatBreeds() async {
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        let breeds = try! StaticJSONMapper.decode(file: "breeds",
                                                  type: [Breed].self);
        self.breedsResponse = BreedsResponse(breeds: breeds)
    }
    
    internal func hasReachedEnd(of breed: Breed) -> Bool {
        breedsResponse?.breeds .last?.id == breed.id
    }
}

// MARK: - State Enum

extension BreedsViewModel {
    
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
