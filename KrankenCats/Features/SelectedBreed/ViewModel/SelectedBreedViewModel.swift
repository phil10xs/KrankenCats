//
//  SelectedBreedViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 30/01/2025.
//

import Foundation


final class  SelectedBreedViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private(set) var  selectedBreedImageResponse:  SelectedBreedImageResponse?
    
    @Published private(set) var  selectedBreed:  Breed?
    
    @Published private(set) var breedImages = [BreedImage]()
    
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
            self.breedImages = self.selectedBreedImageResponse?.breedImages ?? []
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    // MARK: - Internal Methods
    @MainActor
    internal func fetchSelectedBreed() async {
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .selectedBreed(breedId: self.breedId),
                                                               type: Breed.self)
            self.selectedBreed = response
            
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
       internal func fetchNextSelectedBreedImages() async {
           viewState = .loading
           defer { viewState = .finished }
           page += 1
           do {
               let response = try await networkingManager.request(session: .shared,
                                                                  .images(breedIds: self.breedId, page: page),
                                                                  type: [BreedImage].self)
               self.selectedBreedImageResponse = SelectedBreedImageResponse(breedImages: response)
               self.breedImages += self.selectedBreedImageResponse?.breedImages ?? []
           } catch {
               self.hasError = true
               if let networkingError = error as? NetworkingManager.NetworkingError {
                   self.error = networkingError
               } else {
                   self.error = .custom(error: error)
               }
           }
       }
      
    func hasReachedEnd(of breedImage: BreedImage) -> Bool {
        selectedBreedImageResponse?.breedImages.last?.id == breedImage.id
       }
}


extension  SelectedBreedViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

