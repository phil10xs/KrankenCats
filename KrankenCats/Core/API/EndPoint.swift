//
//  EndPoint.swift
//  KrankenCats
//
//  Created by Philip Igboba on 30/01/2025.
//

import Foundation

enum Endpoint {
    case breeds(page: Int)
    case images(breedIds: String, page: Int)
    case selectedBreed(breedId: String)

}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
    }
}

extension Endpoint {
    
    var host: String { ApiEnvironment.baseAPIHost }
    
    var path: String {
        switch self {
        case .breeds:
            return ApiEnvironment.breeds
        case .images:
            return ApiEnvironment.images
        case .selectedBreed(let breedId):
            return ApiEnvironment.selectedBreed.replacingOccurrences(of: "{breedId}", with: breedId)
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .breeds, .images, .selectedBreed:
            return .GET
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .breeds(let page):
            return [
                "page":"\(page)",
                "limit":"10"
            ]
        case .images(let breedIds, let page):
            return [
                "page":"\(page)",
                "limit":"10",
                "breed_ids":breedIds
            ]
        default:
            return nil
        }
    }
}

extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        // Append API key
        requestQueryItems.append(URLQueryItem(name: "api_key", value: ApiEnvironment.apiKey))
//
//        #if DEBUG
//        requestQueryItems.append(URLQueryItem(name: "delay", value: "2"))
//        #endif
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}

