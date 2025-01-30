//
//  SelectedBreedViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 30/01/2025.
//

import Foundation


final class  SelectedBreedViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var  selectedBreedImageResponse:  SelectedBreedImageResponse?
    
    @Published var hasError = false
    
    @Published private(set) var error: NetworkingManager.NetworkingError?
    
    @Published private(set) var viewState: ViewState?
    
    private(set) var page = 0
    
    private let networkingManager: NetworkingManagerImpl!
    
    private let breedId: String
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    // MARK: - Initializer
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared, breedId: String) {
        self.networkingManager = networkingManager
        self.breedId = breedId
    }
    
    // MARK: - Internal Methods
    
    @MainActor
    internal func fetchSelectedBreedImages() async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .images(breedIds: self.breedId, page: page),
                                                               type: [BreedImage].self)
            self.selectedBreedImageResponse = SelectedBreedImageResponse(breedImages: response)
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}


extension  SelectedBreedViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

