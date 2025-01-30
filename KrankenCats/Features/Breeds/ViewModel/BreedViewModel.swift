//
//  BreedViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import Foundation

final class BreedsViewModel: ObservableObject {
    
    @Published private(set) var breedsResponse:  BreedsResponse?
    @Published var hasError = false
    @Published private(set) var viewState: ViewState?
    
    private(set) var page = 1
    private(set) var totalPages: Int?
    
    
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    
    @MainActor
    func fetchCatBreeds() async {
        reset()
        viewState = .loading
        defer { viewState = .finished }
        let breeds = try! StaticJSONMapper.decode(file: "breeds",
                                                               type: [Breed].self);
        self.breedsResponse = BreedsResponse(breeds: breeds)
    }
    
    @MainActor
    func fetchNextSetOfCatBreeds() async {
        
        guard page != totalPages else { return }
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        let breeds = try! StaticJSONMapper.decode(file: "breeds",
                                                               type: [Breed].self);
        self.breedsResponse = BreedsResponse(breeds: breeds)
    }
    
    func hasReachedEnd(of breed: Breed) -> Bool {
        breedsResponse?.breeds .last?.id == breed.id
    }
}
    
    
    extension BreedsViewModel {
        enum ViewState {
            case fetching
            case loading
            case finished
        }
    }

    private extension BreedsViewModel {
        func reset() {
            if viewState == .finished {
                breedsResponse = BreedsResponse(breeds: [])
                page = 1
                totalPages = nil
                viewState = nil
            }
        }
    }

    

