//
//  RecipeListViewModelTests.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/16/24.
//

import XCTest
@testable import FetchTakeHome

final class RecipeListViewModelTests: XCTestCase {
    private var sut: RecipeListViewModel!
    
    override func setUp() {
        super.setUp()
        sut = RecipeListViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_clearSelectedRecipes() {
        let selectedCuisines = sut.selectedCuisines
        
        sut.clearSelectedCuisines()
        
        XCTAssertEqual(selectedCuisines.count, 0)
    }
    
    func test_toggleCuisine() {
        sut.toggleSelectedCuisine("American")
        
        XCTAssertEqual(sut.selectedCuisines.count, 1)
        XCTAssertEqual(sut.selectedCuisines.first, "American")
        
        sut.toggleSelectedCuisine("American")
        
        XCTAssertEqual(sut.selectedCuisines.count, 0)
    }
}
