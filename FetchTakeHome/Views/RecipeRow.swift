//
//  RecipeRow.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/10/24.
//

import SwiftUI
import CachedAsyncImage

struct RecipeRow: View {
    var recipe: Recipe
    @State var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    CachedAsyncImage(url: recipe.imageSmallURL) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                                .font(.title)
                                .foregroundStyle(.secondary)
                            Text(phase.error!.localizedDescription)
                                .font(.caption)
                        } else {
                            ProgressView()
                        }
                        
                    }
                    .frame(width: 80, height: 80)
                }
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(Font.headline)
                    Text(recipe.cuisine)
                        .font(Font.subheadline)
                        .fontWeight(.light)
                }
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                .buttonStyle(.plain)
            }
            if isExpanded {
                HStack {
                    if recipe.youtubeUrl != "" {
                    Spacer()
                        Button(action: {
                            print("Open Youtube URL")
                        }) {
                            Image(systemName: "play.rectangle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 40, height: 40)
                        .buttonStyle(.plain)
                    }
                    Spacer()
                    if recipe.sourceUrl != "" {
                        Button(action: {
                            print("Open Source URL")
                        }) {
                            Image(systemName: "safari")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 40, height: 40)
                        .buttonStyle(.plain)
                    Spacer()
                    }
                }
            }
        }
    }
}
