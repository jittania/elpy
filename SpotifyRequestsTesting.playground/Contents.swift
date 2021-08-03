import Foundation
import PlaygroundSupport

// Create URL
//let url = URL(string: "https://api.spotify.com/v1/search")
let url = URL(string: "https://api.spotify.com/v1/search?q=genre:house&type=track&limit=10")
guard let requestUrl = url else { fatalError() }

// Create URL Request
var request = URLRequest(url: requestUrl)

// Set HTTP Request Header
request.setValue("application/json", forHTTPHeaderField: "Content-Type") // indicates the request content type is JSON
request.setValue("Bearer BQBEjXsbqpkRbQNTJLw8iyEJAyjZxbKlmyHS80ZB12sLp0U-B7h5pFzNw2H_QcvJiWz6_gw01bRgrddxsKY9LaM5tiX5kZcvTWo1mIb-z8ExjZ2sXC8oslF41pBKbAIHQRpMLG0RGdfX2BstHKqmTgq6FpxnCSpuUYjbFzrN_T6MOzyJpCo30lJcSOV2BqG2gDwORPN-VnkGPQJzdAOBNwEXo3zt67IoCjA", forHTTPHeaderField: "Authorization")

// Specify HTTP Method to use
request.httpMethod = "GET"

// Send HTTP Request
let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    
    // Check if Error took place
    if let error = error {
        print("Error took place \(error)")
        return
    }
    
    // Read HTTP Response Status code
    if let response = response as? HTTPURLResponse {
        print("Response HTTP Status code: \(response.statusCode)")
    }
    
    // Convert HTTP Response Data to a simple String
    if let data = data, let dataString = String(data: data, encoding: .utf8) {
        print("Response data string:\n \(dataString)")
    }
    
}
task.resume()
