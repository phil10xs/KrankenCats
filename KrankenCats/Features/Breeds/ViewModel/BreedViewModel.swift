//
//  BreedViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import Foundation

final class BreedsViewModel: CacheableViewModel, Cacheable {
    typealias T = [Breed]
    
    @Published private(set) var breeds: [Breed] = []
    private(set) var breedsResponse: BreedsResponse?
    private(set) var page = 0
    
    var cacheKey: String { "breeds" }
    
    func hash(for parameters: [String: Any]) -> String {
        let page = parameters["page"] as? Int ?? 0
        return "\(cacheKey)_page_\(page)"
    }
    
    @MainActor
       func fetchCatBreeds() async {
           viewState = .loading
           defer { viewState = .finished }
           
           let parameters: [String: Any] = ["page": page]
           if let cachedBreeds: [Breed] = cacheManager.get(for: hash(for: parameters)) {
               self.breeds = cachedBreeds
               return
           }
           
           do {
               let response = try await networkingManager.request(session: .shared,
                                                              .breeds(page: page),
                                                              type: [Breed].self)
               self.breedsResponse = BreedsResponse(breeds: response)
               self.breeds = breedsResponse?.breeds ?? []
               cacheManager.set(self.breeds, for: hash(for: parameters))
           } catch {
               handleError(error)
           }
       }
       
       @MainActor
       func fetchNextSetOfCatBreeds() async {
           viewState = .fetching
           defer { viewState = .finished }
           
           let nextPage = page + 1
           let parameters: [String: Any] = ["page": nextPage]
           
           if let cachedBreeds: [Breed] = cacheManager.get(for: hash(for: parameters)) {
               self.breeds += cachedBreeds
               self.page = nextPage
               return
           }
           
           page += 1
           do {
               let response = try await networkingManager.request(session: .shared,
                                                              .breeds(page: page),
                                                              type: [Breed].self)
               self.breedsResponse = BreedsResponse(breeds: response)
               let newBreeds = breedsResponse?.breeds ?? []
               self.breeds += newBreeds
               cacheManager.set(newBreeds, for: hash(for: parameters))
           } catch {
               handleError(error)
           }
       }
    
    func hasReachedEnd(of breed: Breed) -> Bool {
        breedsResponse?.breeds.last?.id == breed.id
    }
}

// MARK: - State Enum
enum ViewState {
    case fetching
    case loading
    case finished
}

// MARK: - Cache Helper

final class CachedBreeds: NSObject {
    let breeds: [Breed]
    let breedsResponse: BreedsResponse?
    
    init(breeds: [Breed], breedsResponse: BreedsResponse?) {
        self.breeds = breeds
        self.breedsResponse = breedsResponse
        super.init()
    }
}


