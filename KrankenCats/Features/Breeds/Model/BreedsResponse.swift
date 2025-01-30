//
//  BreedsResponse.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import Foundation

struct BreedsResponse: Codable, Equatable {
    let breeds: [Breed]
}

struct Breed: Codable, Equatable {
    struct Image: Codable, Equatable {
        let id: String
        let width: Int
        let height: Int
        let url: String
    }
    
    struct Weight: Codable, Equatable {
        let imperial: String
        let metric: String
    }

    let id: String
    let description: String
    let name: String
    let countryCode: String
    let image: Image
    let weight: Weight
}


