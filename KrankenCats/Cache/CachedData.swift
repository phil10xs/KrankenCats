//
//  CachedData.swift
//  KrankenCats
//
//  Created by Philip Igboba on 01/02/2025.
//

import Foundation


// MARK: - Cached Data
final class CachedData: NSObject {
    let data: Any
    
    init(data: Any) {
        self.data = data
        super.init()
    }
}
