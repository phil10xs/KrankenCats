//
//  NetworkingManagerSuccessMock.swift
//  KrankenCats
//
//  Created by Philip Igboba on 02/02/2025.
//

import Foundation

#if DEBUG
import Foundation

class NetworkingManagerBreedResponseSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable {
        // Return a list of mock Breed objects
        return try generateMockBreeds() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws { }
    
    // Helper method to generate a mock list of breeds
    private func generateMockBreeds() -> [Breed] {
        return [
            Breed(
                weight: Breed.Weight(imperial: "7 - 10", metric: "3 - 5"),
                id: "abys",
                name: "Abyssinian",
                cfaURL: "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
                vetstreetURL: "http://www.vetstreet.com/cats/abyssinian",
                vcahospitalsURL: "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
                temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                origin: "Egypt",
                countryCodes: "EG",
                countryCode: "EG",
                description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
                lifeSpan: "14 - 15",
                indoor: 0,
                lap: 1,
                altNames: "",
                adaptability: 5,
                affectionLevel: 5,
                childFriendly: 3,
                dogFriendly: 4,
                energyLevel: 5,
                grooming: 1,
                healthIssues: 2,
                intelligence: 5,
                sheddingLevel: 2,
                socialNeeds: 5,
                strangerFriendly: 5,
                vocalisation: 1,
                experimental: 0,
                hairless: 0,
                natural: 1,
                rare: 0,
                rex: 0,
                suppressedTail: 0,
                shortLegs: 0,
                wikipediaURL: "https://en.wikipedia.org/wiki/Abyssinian_(cat)",
                hypoallergenic: 0,
                referenceImageID: "0XYvRd7oD",
                image: Breed.Image(id: "0XYvRd7oD", width: 1204, height: 1445, url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg")
            ),
            Breed(
                weight: Breed.Weight(imperial: "6 - 10", metric: "2.7 - 4.5"),
                id: "pers",
                name: "Persian",
                cfaURL: "http://cfa.org/Breeds/BreedsAB/Persian.aspx",
                vetstreetURL: "http://www.vetstreet.com/cats/persian",
                vcahospitalsURL: "https://vcahospitals.com/know-your-pet/cat-breeds/persian",
                temperament: "Affectionate, Playful, Gentle, Quiet",
                origin: "Iran",
                countryCodes: "IR",
                countryCode: "IR",
                description: "The Persian is one of the oldest and most beloved cat breeds.",
                lifeSpan: "12 - 16",
                indoor: 1,
                lap: 1,
                altNames: "",
                adaptability: 3,
                affectionLevel: 5,
                childFriendly: 4,
                dogFriendly: 3,
                energyLevel: 2,
                grooming: 5,
                healthIssues: 3,
                intelligence: 4,
                sheddingLevel: 5,
                socialNeeds: 3,
                strangerFriendly: 2,
                vocalisation: 2,
                experimental: 0,
                hairless: 0,
                natural: 1,
                rare: 0,
                rex: 0,
                suppressedTail: 0,
                shortLegs: 0,
                wikipediaURL: "https://en.wikipedia.org/wiki/Persian_cat",
                hypoallergenic: 0,
                referenceImageID: "3a5v1RHtP",
                image: Breed.Image(id: "3a5v1RHtP", width: 1280, height: 1280, url: "https://cdn2.thecatapi.com/images/3a5v1RHtP.jpg")
            )
        ]
    }
}
#endif

