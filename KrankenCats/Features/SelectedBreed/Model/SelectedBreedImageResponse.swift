//
//  SelectedBreedImageResponse.swift
//  KrankenCats
//
//  Created by Philip Igboba on 30/01/2025.
//

import Foundation

struct SelectedBreedImageResponse: Codable, Equatable {
    let breedImages: [BreedImage]
}


struct BreedImage: Codable, Equatable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

