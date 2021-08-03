import Foundation
import PlaygroundSupport

// Create URL
let url = URL(string: "https://api.spotify.com/v1/search")
// let url = URL(string: "https://api.spotify.com/v1/search?q=genre:house&type=track&limit=1")
guard let requestUrl = url else { fatalError() }

// Create URL Request
var request = URLRequest(url: requestUrl)

// Set HTTP Request Header
request.setValue("application/json", forHTTPHeaderField: "Content-Type") // indicates the request content type is JSON
request.setValue("Bearer BQCSoRYTLVfVekCY7OWk_5HUEpxPL_U_rWWCzyjugcqRb_TCbD2V1amaT05sTcsKkPmcnLSV4h2-xc1VkPk38QL9dj1MAJPKMcPpFqbwRO3ZyTaTXTkQ7KJv6IjIrCy-IjeelBrfGOzP_OW5C8M", forHTTPHeaderField: "Authorization")

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
