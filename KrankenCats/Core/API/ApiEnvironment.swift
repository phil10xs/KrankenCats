//
//  ApiEnvironment.swift
//  KrankenCats
//
//  Created by Philip Igboba on 30/01/2025.
//

import Foundation

enum ApiEnvironment {}

// MARK: - Base URL

extension ApiEnvironment {
    
    static var baseAPIHost: String {
        "api.thecatapi.com"
    }
    
    static var apiKey: String {
        "live_uz999UiclEF8cKZQL4Iwe4s4EsGqtJEF12bWgF5Tpblxq8JAVZM0GE8WOnmEaFqT"
    }
}

// MARK: - Endpoints

extension ApiEnvironment {
    
    static var breeds: String {
        "/v1/breeds"
    }
    
    static var images: String {
       "/v1/images/search"
    }
    
    static var selectedBreed: String {
        "/v1/breeds/{breedId}"
    }
}
