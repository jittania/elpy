import Foundation


struct TrackResponse: Codable {
    var tracks: TrackData
}

struct TrackData: Codable {
    var items: [Track]
    
}
     

