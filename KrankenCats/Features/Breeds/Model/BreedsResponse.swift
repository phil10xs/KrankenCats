//
//  BreedsResponse.swift
//  KrankenCats
//
//  Created by Philip Igboba on 29/01/2025.
//

import Foundation

struct BreedsResponse: Codable {
    let breeds: [Breed]
}

struct Breed: Codable {
    struct Weight: Codable {
        let imperial: String
        let metric: String
    }
    
    struct Image: Codable {
        let id: String?
        let width: Int?
        let height: Int?
        let url: String?
    }
    
    let weight: Weight
    let id: String
    let name: String
    let cfaURL: String?
    let vetstreetURL: String?
    let vcahospitalsURL: String?
    let temperament: String?
    let origin: String?
    let countryCodes: String?
    let countryCode: String?
    let description: String?
    let lifeSpan: String?
    let indoor: Int
    let lap: Int?
    let altNames: String?
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let intelligence: Int
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressedTail: Int
    let shortLegs: Int
    let wikipediaURL: String?
    let hypoallergenic: Int
    let referenceImageID: String?
    let image: Image?
    
    enum CodingKeys: String, CodingKey {
        case weight, id, name, temperament, origin, description, indoor, lap, adaptability, affectionLevel = "affection_level"
        case childFriendly = "child_friendly", dogFriendly = "dog_friendly", energyLevel = "energy_level"
        case grooming, healthIssues = "health_issues", intelligence, sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs", strangerFriendly = "stranger_friendly", vocalisation
        case experimental, hairless, natural, rare, rex, suppressedTail = "suppressed_tail", shortLegs = "short_legs"
        case cfaURL = "cfa_url", vetstreetURL = "vetstreet_url", vcahospitalsURL = "vcahospitals_url"
        case countryCodes = "country_codes", countryCode = "country_code", lifeSpan = "life_span"
        case altNames = "alt_names", wikipediaURL = "wikipedia_url", hypoallergenic, referenceImageID = "reference_image_id"
        case image
    }
}
