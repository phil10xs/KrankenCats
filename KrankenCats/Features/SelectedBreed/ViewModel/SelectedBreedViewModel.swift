//
//  SelectedBreedViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 30/01/2025.
//

import Foundation

final class SelectedBreedViewModel: CacheableViewModel, Cacheable {
    // MARK: - Type Alias
    typealias T = [BreedImage]
    
    // MARK: - Properties
    private(set) var selectedBreedImageResponse: SelectedBreedImageResponse?
    @Published private(set) var selectedBreed: Breed?
    @Published private(set) var breedImages = [BreedImage]()
    private(set) var page = 0
    private let breedId: String
    
    var cacheKey: String { "selected_breed" }
    
    // MARK: - Initializer
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared,
         cacheManager: CacheManager = .shared,
         breedId: String) {
        self.breedId = breedId
        super.init(networkingManager: networkingManager, cacheManager: cacheManager)
    }
    
    // MARK: - Cache Methods
    func hash(for parameters: [String: Any]) -> String {
        let page = parameters["page"] as? Int ?? 0
        let type = parameters["type"] as? String ?? ""
        return "\(cacheKey)_\(breedId)_\(type)_page_\(page)"
    }
    
    // MARK: - Internal Methods
    @MainActor
    internal func fetchSelectedBreedImages() async {
        viewState = .loading
        defer { viewState = .finished }
        
        let parameters: [String: Any] = [
            "page": page,
            "type": "images"
        ]
        
        if let cachedImages: [BreedImage] = cacheManager.get(for: hash(for: parameters)) {
            self.selectedBreedImageResponse = SelectedBreedImageResponse(breedImages: cachedImages)
            self.breedImages = cachedImages
            return
        }
        
        do {
            let response = try await networkingManager.request(
                session: .shared,
                .images(breedIds: self.breedId, page: page),
                type: [BreedImage].self
            )
            self.selectedBreedImageResponse = SelectedBreedImageResponse(breedImages: response)
            self.breedImages = self.selectedBreedImageResponse?.breedImages ?? []
            cacheManager.set(self.breedImages, for: hash(for: parameters))
        } catch {
            handleError(error)
        }
    }
    
    @MainActor
    internal func fetchSelectedBreed() async {
        viewState = .loading
        defer { viewState = .finished }
        
        let parameters: [String: Any] = [
            "type": "breed_details"
        ]
        
        if let cachedBreed: Breed = cacheManager.get(for: hash(for: parameters)) {
            self.selectedBreed = cachedBreed
            return
        }
        
        do {
            let response = try await networkingManager.request(
                session: .shared,
                .selectedBreed(breedId: self.breedId),
                type: Breed.self
            )
            self.selectedBreed = response
            cacheManager.set(response, for: hash(for: parameters))
        } catch {
            handleError(error)
        }
    }
    
    @MainActor
    internal func fetchNextSelectedBreedImages() async {
        viewState = .fetching
        defer { viewState = .finished }
        
        let nextPage = page + 1
        let parameters: [String: Any] = [
            "page": nextPage,
            "type": "images"
        ]
        
        if let cachedImages: [BreedImage] = cacheManager.get(for: hash(for: parameters)) {
            self.selectedBreedImageResponse = SelectedBreedImageResponse(breedImages: cachedImages)
            self.breedImages += cachedImages
            self.page = nextPage
            return
        }
        
        page += 1
        do {
            let response = try await networkingManager.request(
                session: .shared,
                .images(breedIds: self.breedId, page: page),
                type: [BreedImage].self
            )
            self.selectedBreedImageResponse = SelectedBreedImageResponse(breedImages: response)
            self.breedImages += self.selectedBreedImageResponse?.breedImages ?? []
            cacheManager.set(response, for: hash(for: parameters))
        } catch {
            handleError(error)
        }
    }
    
    func hasReachedEnd(of breedImage: BreedImage) -> Bool {
        selectedBreedImageResponse?.breedImages.last?.id == breedImage.id
    }
}
