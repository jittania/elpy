import Foundation

struct Track: Codable, Identifiable { // 1
    var id = UUID() // 2
    let trackId: String
    let trackTitle: String

    enum CodingKeys: String, CodingKey {
        case trackId = "id" // 3
        case trackTitle = "name"
    }
}

// 1) Track is one of two necessary models for the data we will fetch (TrackResponse is the other one) - create a separate file for each

// 2) The Track model has 3 attributes -

// 3) the values, ex: "name" here must match the keys used in Spotify's JSON response object
