//
//  RecipeList.swift
//  FetchTakeHome
//
//  Created by Christian Grise on 10/10/24.
//

import Foundation
import UIKit

final class RecipeList {
    let recipes: [Recipe]
    var lastUpdated: Date?
    
    let smallImageCache = NSCache<NSString, UIImage>()
    let largeImageCache = NSCache<NSString, UIImage>()
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}
