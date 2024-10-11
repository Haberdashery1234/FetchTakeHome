//
//  RecipeListViewModel.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/10/24.
//

import Foundation

class RecipeListViewModel: ObservableObject {
    var recipes: [Recipe] = []
    var filteredRecipes: [Recipe] {
        if selectedCuisines.isEmpty {
            return recipes
        } else {
            return recipes.filter( { selectedCuisines.contains($0.cuisine) })
        }
    }
    
    @Published var cuisines: [String] = []
    @Published var selectedCuisines: [String] = []
    
    private let session = URLSession(configuration: .default)
    
    func clearSelectedCuisines() {
        selectedCuisines.removeAll()
        selectedCuisines.append(contentsOf: cuisines)
    }
    
    func toggleSelectedCuisine(_ cuisine: String) {
        if selectedCuisines.contains(cuisine) {
            selectedCuisines.removeAll(where: { $0 == cuisine })
        } else {
            selectedCuisines.append(cuisine)
        }
    }
    
    func fetchRecipes() async throws {
        let recipeListEndpoint = RecipeListEndPoint.init()
        recipes = try await recipeListEndpoint.fetchRecipesWithContinuation() ?? []
        DispatchQueue.main.async {
            self.cuisines = Array(Set(self.recipes.map { $0.cuisine })).sorted()
        }
    }
}
