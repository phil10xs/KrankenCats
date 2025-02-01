//
//  BreedsViewModel.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import SwiftUI

struct BreedsView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    @ObservedObject var viewModel: BreedsViewModel
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationView{
            ZStack {
                background
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack{
                            LazyVGrid(columns: columns,
                                      spacing: 16) {
                                ForEach(viewModel.breeds, id: \.id) { breed in
                                    NavigationLink {
                                        SelectedBreedView(viewModel: .init(breedId: breed.id))
                                    } label: {
                                        SingleBreedView(breed: breed)
                                            .accessibilityIdentifier("item_\(breed.id)")
                                            .task {
                                                if viewModel.hasReachedEnd(of: breed) && !viewModel.isFetching {
                                                    await viewModel.fetchNextSetOfCatBreeds()
                                                }
                                            }
                                    }
                                }
                            }
                                      .padding()
                                      .accessibilityIdentifier("BreedGrid")
                        }
                    }
                    .refreshable {
                        await viewModel.fetchCatBreeds();
                    }
                    .overlay(alignment: .bottom) {
                        if viewModel.isFetching {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("Breeds")
            .task {
                if !hasAppeared {
                    await viewModel.fetchCatBreeds()
                    hasAppeared = true
                }
            }
        }
    }
}

private extension BreedsView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var refresh: some View {
        Button {
            Task {
             
            }
        } label: {
            Symbols.refresh
        }
        .disabled(viewModel.isLoading)
    }
}
