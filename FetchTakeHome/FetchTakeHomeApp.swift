//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/10/24.
//

import SwiftUI

let currentEnvironment: EnvironmentType = .development

@main
struct FetchTakeHomeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var recipeListViewModel = RecipeListViewModel()
    
    var body: some Scene {
        WindowGroup {
            RecipeListView(selectedCuisines: [])
                .environmentObject(recipeListViewModel)
        }
    }
}
