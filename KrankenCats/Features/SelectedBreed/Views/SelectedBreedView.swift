//
//  SelectedBreedView.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import SwiftUI

struct SelectedBreedView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    @ObservedObject var vm: SelectedBreedViewModel
    @State private var hasAppeared = false
    
    var body: some View {
        ZStack {
            background
            if vm.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack{
                        LazyVGrid(columns: columns,
                                  spacing: 16) {
                            ForEach(vm.selectedBreedImageResponse?.breedImages ?? [], id: \.id) { breedImage in
                                NavigationLink {
//                                    SelectedBreedView(breedId: breed.id)
                                } label: {
                                    SingleBreedImageView(breedImage: breedImage)
                                        .accessibilityIdentifier("item_\(breedImage.id)")
                                       
                                }
                            }
                        }
                                  .padding()
                                  .accessibilityIdentifier("peopleGrid")
                    }
                }
                .refreshable {
                    await vm.fetchSelectedBreedImages()
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
                await vm.fetchSelectedBreedImages()
                hasAppeared = true
            }
        }
    }
}

private extension SelectedBreedView {
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


