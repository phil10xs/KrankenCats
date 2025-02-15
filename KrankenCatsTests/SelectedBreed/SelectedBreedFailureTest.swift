//
//  SelectedBreedFailureTest.swift
//  KrankenCatsTests
//
//  Created by Philip Igboba on 02/02/2025.
//

import XCTest
@testable import KrankenCats


class SelectedBreedFailureTests: XCTestCase {
    private var networkingMock: NetworkingManagerImpl!
    private var vm:  SelectedBreedViewModel!
    
    override func setUp() {
        networkingMock =  NetworkingManagerSelectedBreedResponseFailureMock()
        vm = SelectedBreedViewModel(networkingManager: networkingMock, breedId: "abys")
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    

    func test_with_unsuccessful_response_error_is_handled() async {

        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        
        await vm.fetchSelectedBreed()
        
        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertNotNil(vm.error, "The view model error should be set")
    }
}
