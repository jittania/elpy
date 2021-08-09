//
//  SpotifyAPI.swift
//  ButtonGetsSpotifyTracks
//
//  Created by Jittania Smith on 8/4/21.
//

import Foundation
import Combine

// 1
enum SpotifyDB {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://api.spotify.com/v1/")!
}

// 2
enum APIPath: String {
    case searchForTracks = "search"
}

extension SpotifyDB {
    static func request(_ path: APIPath) -> AnyPublisher<TrackResponse, Error> {
        // 3
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: "artist:missy elliot"),
            URLQueryItem(name: "type", value: "track")
        ] // 4
        
        var request = URLRequest(url: components.url!) // changed let to var (was let in original tutorial) in order to be able to add request method
        
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer ...", forHTTPHeaderField: "Authorization")
        
        print("I'm in the SpotifyDB extension!")
        print("3) SpotifyDB has built the URL request and sending it to APIClient, which is calling the Spotify API")
        // print("Logging components object:", components)
        print("================================")
        
        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
}

// 1) Set up the basics needed for making the request
// 2) Set up the paths we want to be able to call from the API.
// 3) Here we create the URL request. The request is a GET-request by default, hence we don’t need to specify that.
// 4) Add the api_key you created at The Movie Database here!
// 5) We run the newly created request through our API client
// 6) 'value' here is the attribute of to Response<T> in APIClient 
// Map is our operator, that lets us set the type of output we want. \.value in this case, is our generic type defined as return value of this method (MoviesData), since the client returns a Response-object, which contains both a value and a response property, but for now, we’re only interested in the value.
// 7) This call cleans up the return type from something like Publishers.MapKeyPath<AnyPublisher<APIClient.Response<MoviesData>, Error>, T> to the expected type: AnyPublisher<MoviesData, Error>

