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
    @ObservedObject var viewModel: SelectedBreedViewModel
    @State private var hasAppeared = false
    
    var body: some View {
        ZStack {
            background
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    DetailView(viewModel: viewModel)
                    VStack{
                        LazyVGrid(columns: columns,
                                  spacing: 8) {
                            ForEach(viewModel.breedImages, id: \.id) { breedImage in
                                SingleBreedImageView(breedImage: breedImage)
                                    .accessibilityIdentifier("item_\(breedImage.id)")
                            }
                        }
                                  .padding()
                                  .accessibilityIdentifier("SelectedBreedGrid")
                    }
                }
                .overlay(alignment: .bottom) {
                    if viewModel.isFetching {
                        ProgressView()
                    }
                }
            }
        }
        .navigationTitle("Breed Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if !hasAppeared {
                await viewModel.fetchSelectedBreed()
                await viewModel.fetchSelectedBreedImages()
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
}
