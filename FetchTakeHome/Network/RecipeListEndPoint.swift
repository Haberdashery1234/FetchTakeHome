//
//  RecipeList.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/2/24.
//

import Foundation

struct RecipeListResponse: Decodable {
    let recipes: [Recipe]
}

struct RecipeListEndPoint: ResourceEndPoint {
    typealias Response = RecipeListResponse
    
    var path: String = "recipes.json"
    
    var availableHTTPMethods: [HTTPMethod] = [.GET]
    
    func fetchRecipes(completion: @escaping (Result<RecipeListResponse, Error>) -> Void) {
        let fullPath =  currentEnvironment.url.absoluteString.appending(path)
        guard let url = URL(string: fullPath) else {
            completion(.failure(FTHError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(FTHError.invalidResponse))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RecipeListResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchRecipesWithContinuation() async throws -> [Recipe]? {
        let recipes: [Recipe] = try await withCheckedThrowingContinuation { continuation in
            fetchRecipes { result in
                switch result {
                    case .success(let response):
                        continuation.resume(returning: response.recipes)
                    case .failure(let error):
                        continuation.resume(throwing: FTHError.invalidResponse)
                }
            }
        }
        return recipes
    }
}
