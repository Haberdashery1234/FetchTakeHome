//
//  ContentView.swift
//  AndysWay
//
//  Created by Christian Grise on 9/27/24.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject private var model: RecipeListViewModel
    
    @State var showActionSheet = false
    @State var selectedCuisines: Set<String>
    
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 1)
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Rectangle()
                        .frame(height: 0)
                        .background(Color.green.opacity(0.2))
                }
                .navigationTitle("Recipes")
                .font(.title2)
                .navigationBarTitleDisplayMode(.inline)
            }

            List(model.filteredRecipes) { recipe in
                RecipeRow(recipe: recipe)
            }
            .task { await refresh() }
            .refreshable {
                model.recipes = []
                await refresh()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        Task {
                            await refresh()
                        }
                    }) {
                        Label("Refresh", systemImage: "arrow.clockwise").colorInvert()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        self.showActionSheet = true
                    }) {
                        Label("Filter", systemImage: "ellipsis.circle.fill")
                    }.popover(isPresented: $showActionSheet) {
                        VStack(alignment: .leading) {
                            Text("Select cuisines")
                                .font(.title3)
                                .padding(.horizontal)

                            Divider()

                            ScrollView {
                                LazyVGrid(columns: gridColumns) {
                                    Button("Select all") {
                                        model.clearSelectedCuisines()
                                    }
                                    
                                    ForEach($model.cuisines) { $cuisine in
                                        Button(cuisine) {
                                            model.toggleSelectedCuisine(cuisine)
                                        }
                                            .buttonStyle(.plain)
                                            .frame(minWidth: 100, maxWidth: 200, minHeight: 25, maxHeight: 30, alignment: .leading)
                                    }
                                }
                            }
                            .padding()
                            .frame(alignment: .leading)
                        }
                        .padding(.vertical)
                        .presentationCompactAdaptation(.none)
                    }
                }
            }
        }
    }
    
    //MARK: - methods
    func refresh() async {
        try? await model.fetchRecipes()
    }
}

#Preview {
    RecipeListView(selectedCuisines: [])
}

