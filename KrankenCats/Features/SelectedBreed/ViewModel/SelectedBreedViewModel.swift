//
//  SelectedBreedViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 30/01/2025.
//

import Foundation


final class  SelectedBreedViewModel: ObservableObject {
    
    @Published private(set) var  selectedBreedImageResponse:  SelectedBreedImageResponse?
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
    func fetchSelectedBreedImages() async {
        viewState = .loading
        defer { viewState = .finished }
        let selectedBreedImages = try! StaticJSONMapper.decode(file: "selected_breed",
                                                               type: [BreedImage].self);
        self.selectedBreedImageResponse = SelectedBreedImageResponse(breedImages: selectedBreedImages)
    }
}


extension  SelectedBreedViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

