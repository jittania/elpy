//
//  TrackResponse.swift
//  elpy
//
//  Created by Jittania Smith on 8/6/21.
//

import Foundation


struct TrackResponse: Codable {
    var tracks: TrackData
}

struct TrackData: Codable {
    var items: [Track]
    
}
     

