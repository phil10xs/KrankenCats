//
//  KrankenCatsTests.swift
//  KrankenCatsTests
//
//  Created by Philip Igboba on 29/01/2025.
//

import XCTest
@testable import KrankenCats

final class SelectedBreedSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var vm:  SelectedBreedViewModel!
    
    override func setUp() {
        networkingMock =  NetworkingManagerSelectedBreedResponseSuccessMock()
        vm = SelectedBreedViewModel(networkingManager: networkingMock, breedId: "abys")
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_successful_response_selected_breed_is_set() async throws {
       
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        await vm.fetchSelectedBreed()
        XCTAssertEqual(vm.selectedBreed?.id, "abys", "There should be a selected breed id")
    }
}
