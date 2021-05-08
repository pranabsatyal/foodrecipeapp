//
//  RecipeInfo.swift
//  Food Recipe
//
//  Created by Pranab Raj Satyal on 5/4/21.
//

import UIKit

struct RecipeInfo: Codable {
    var label: String
    var url: String
    var image: String
    var source: String
    var healthLabels: [String]
}
