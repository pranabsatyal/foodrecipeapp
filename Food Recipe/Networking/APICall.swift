//
//  APICall.swift
//  Food Recipe
//
//  Created by Pranab Raj Satyal on 5/4/21.
//

import UIKit

enum URLError: Error {
    case invalidURL
}

class APICall {
    
    static let shared = APICall()
    
    var dishName = ""
    
    func apiCalls(completion: @escaping ([Recipe]?, Error?) -> Void) {
        
        if dishName != "" {
            dishName = dishName.lowercased()
            dishName = dishName.replacingOccurrences(of: " ", with: "%20")
            dishName = dishName.replacingOccurrences(of: "  ", with: "%20")
        }
        
        let urlString = "https://api.edamam.com/search?q=\(dishName)&app_id=937c260a&app_key=ed2a7a21ff56fca01796b0c085785e97&from=0&to=20&calories=591-722&health=alcohol-free"
        
        guard let url = URL(string: urlString) else {
            return
            
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            if let safeData = data {
                self.parseJSON(safeData) { (recipe, error)  in
                    if error != nil {
                        completion(nil, URLError.invalidURL)
                    }
                    
                    if let recipe = recipe {
                        completion(recipe, nil)
                    }
                }
                
            }
            
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data, completion: ([Recipe]?, Error?) -> Void) {
        let decoder = JSONDecoder()
        
        
        do {
            let recipe = try decoder.decode(Hits.self, from: data)
            
            if recipe.hits.isEmpty {
                completion(nil, URLError.invalidURL)
            } else {
                completion(recipe.hits, nil)
            }
        } catch {
            // handle error
        }
    }
    
}


