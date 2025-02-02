//
//  BreedSuccessTest.swift
//  KrankenCatsTests
//
//  Created by Philip Igboba on 02/02/2025.
//

import XCTest
@testable import KrankenCats

final class BreedSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var vm:  BreedsViewModel!
    
    override func setUp() {
        networkingMock =   NetworkingManagerBreedResponseSuccessMock()
        vm = BreedsViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_successful_response_users_array_is_set() async throws {
       
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        await vm.fetchCatBreeds()
        XCTAssertEqual(vm.breeds.count, 2, "There should be a 10 items")
    }
}
