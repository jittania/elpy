//
//  APIClient.swift
//  ButtonGetsSpotifyTracks
//
//  Created by Jittania Smith on 8/4/21.
//

import Foundation
import Combine

struct APIClient {

    struct Response<T> { // 1
        let value: T  // T is an arbitrary type
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
        // print("I'm in APIClient trying to make a request!")
       
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                // print("I got a response and am trying to parse it!")
                // print("Here is result.response:", result.response)
                // print("================================")
                
                let value = try JSONDecoder().decode(T.self, from: result.data) // 4
                print("I'm in the API Client model!")
                print("4) Got data back from Spotify API and have used TrackResponse to decode it")
                print("-> Logging decoded data type, which should be of type TrackResponse:", type(of: value))
                print("5) Then used TrackData > Track models to further parse data, in order to get an array of Track objects")
                // print("I decoded the data and am trying to return it!")
                // print("Here is the decoded data:", value)
                print("6) Publisher is sending back a properly decoded Response object to the operator")
                print("================================")
                return Response(value: value, response: result.response) // 5
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}

// 1) This is our generic response object. The value property will be the actual object, and the response property will be the URL response including status code etc.
// 2) This is our only entry point for network requests, no matter if it’s GET, POST or whatever - it’s all specified in the request parameter.
// 3) Here we are “turning the URLSession into a publisher”
// 4) Decode the result to the generic type we defined in the APIClient (in this case TrackResponse)
// 5) Our “homemade” Response object now contains the actual data + the URL response from which we can find status code etc.
// 6) Return the result on the main thread
// 7) We end with erasing the publisher’s type, since it can be very long and “complicated”, and then transform and return it as the return type we want (AnyPublisher<Response<T>, Error>)
