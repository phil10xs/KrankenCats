//
//  CacheManager.swift
//  KrankenCats
//
//  Created by Philip Igboba on 01/02/2025.
//

import Foundation

// MARK: - Cache Protocol
protocol Cacheable {
    associatedtype T
    var cacheKey: String { get }
    func hash(for parameters: [String: Any]) -> String
}

// MARK: - Cache Manager
final class CacheManager {
    static let shared = CacheManager()
    private let cache = NSCache<NSString, CachedData>()
    
    private init() {
        cache.countLimit = 100
    }
    
    func set<T>(_ data: T, for key: String) {
        let cached = CachedData(data: data)
        cache.setObject(cached, forKey: key as NSString)
    }
    
    func get<T>(for key: String) -> T? {
        guard let cached = cache.object(forKey: key as NSString) else { return nil }
        return cached.data as? T
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}
