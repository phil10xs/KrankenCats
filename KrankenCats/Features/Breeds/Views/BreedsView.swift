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
    @ObservedObject var vm: BreedsViewModel
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationView{
            ZStack {
                background
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack{
                            LazyVGrid(columns: columns,
                                      spacing: 16) {
                                ForEach(vm.breedsResponse?.breeds ?? [], id: \.id) { breed in
                                    NavigationLink {
                                        SelectedBreedView(vm: .init(breedId: breed.id))
                                    } label: {
                                        SingleBreedView(breed: breed)
                                            .accessibilityIdentifier("item_\(breed.id)")
//                                            .task {
//                                                if vm.hasReachedEnd(of: breed) && !vm.isFetching {
//                                                    await vm.fetchNextSetOfCatBreeds()
//                                                }
//                                            }
                                    }
                                }
                            }
                                      .padding()
                                      .accessibilityIdentifier("peopleGrid")
                        }
                    }
                    .refreshable {
                        await vm.fetchCatBreeds();
                    }
                    .overlay(alignment: .bottom) {
                        if vm.isFetching {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("Breeds")
            .task {
                if !hasAppeared {
                    await vm.fetchCatBreeds()
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
        .disabled(vm.isLoading)
    }
}
