//
//  NetworkingManagerFailureMock.swift
//  KrankenCats
//
//  Created by Philip Igboba on 02/02/2025.
//

import Foundation

#if DEBUG
import Foundation

class NetworkingManagerBreedResponseFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {}
}
#endif
