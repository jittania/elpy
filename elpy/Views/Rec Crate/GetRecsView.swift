import Foundation
import SwiftUI
import SpotifyWebAPI
import Combine

struct GetRecsView: View {

    @EnvironmentObject var spotify: Spotify

    @State var tracks: [Track] = []
    @State var trackURIs: [String] = []
    
    @Binding var seedGenres: [String]
    @Binding var popularity: Double
    @Binding var danceability: Double
    @Binding var instrumentalness: Double
    @Binding var acousticness: Double
    @Binding var valence: Double
    
    @State private var alert: AlertItem? = nil
    @State private var isSearching = false
    @State private var searchCancellable: AnyCancellable? = nil
    
    var body: some View {
        VStack {
            Button("Build Crate!") {
                getTrackRecs()
            }
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )

            Spacer()
            
            if tracks.isEmpty {
                if isSearching {
                    HStack {
                        ProgressView()
                            .padding()
                        Text("Searching")
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                    
                }
                else {
                    Text("No Results")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
            else {
                Text("Tap a track to play it")
                    .foregroundColor(.secondary)

                List {
                    ForEach(tracks, id: \.self) { track in
                        TrackView(track: track)
                    }
                }
            }
            Spacer()
            NavigationLink(
                "Save Crate", destination: CreatePlaylistView(trackURIs: self.$trackURIs)
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            NavigationLink(
                "Try again!", destination: SeedGenresView()
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            NavigationLink(
                "Home", destination: MainNavigationView()
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
        }
        .alert(item: $alert) { alert in
            Alert(title: alert.title, message: alert.message)
        }
    }
    
    
    
    /// Performs a search for recommended tracks based on `TrackAttributes`.
    /// Successful response ->  Array[Track] saved to `self.tracks`
    
    func getTrackRecs() {
        
        // resets the search
        self.tracks = []
        self.trackURIs = []
        
        //==========================================
        // other values will either be received as 0 or something else
        var popularity: AttributeRange<Int>?
        var danceability: AttributeRange<Double>?
        var instrumentalness: AttributeRange<Double>?
        var acousticness: AttributeRange<Double>?
        var valence: AttributeRange<Double>?
        
        // need to check if values are not zero.
        // if not zero, must convert to proper type and plug into
        // .init(target: <val>) format
        if self.popularity != 0 {
            popularity = .init(target: Int(self.popularity))
        }
        
        if self.instrumentalness != 0 {
            instrumentalness = .init(target: self.instrumentalness)
        }
        
        if self.danceability != 0 {
            danceability = .init(target: self.danceability)
        }
        
        if self.acousticness != 0 {
            acousticness = .init(target: self.acousticness)
        }
        
        if self.valence != 0 {
            valence = .init(target: self.valence)
        }

        // need to assign genres array to trackAttributes object
        // then add other attributes
        
        print("Logging var danceability: \(String(describing: danceability))")
        
        let trackAttributesObj = TrackAttributes(
            seedGenres: self.seedGenres,
            acousticness: acousticness,
            danceability: danceability,
            instrumentalness: instrumentalness,
            popularity: popularity,
            valence: valence
        )
        
        //==========================================
        
        self.isSearching = true
        
        self.searchCancellable = spotify.api.recommendations(
            trackAttributesObj,
            limit: 30
        )
        .receive(on: RunLoop.main)
        .sink(
            receiveCompletion: { completion in
                self.isSearching = false
                if case .failure(let error) = completion {
                    self.alert = AlertItem(
                        title: "Couldn't Perform Search",
                        message: error.localizedDescription
                    )
                }
            },
            receiveValue: { recommendationsResponse in
               
                self.tracks = recommendationsResponse.tracks

                for track in self.tracks {
                    self.trackURIs.append(track.uri!)
                }
                
                print(self.trackURIs)
                print("Request for \(self.tracks.count) tracks received!")
            }
        )
    }
    
}


//struct GetRecsVieww_Previews: PreviewProvider {
//
//    static let spotify = Spotify()
//
//    static let tracks: [Track] = [
//        .because, .comeTogether, .odeToViceroy, .illWind,
//        .faces, .theEnd, .time, .theEnd, .reckoner
//    ]
//
//    static var previews: some View {
//        NavigationView {
//            BuildCrateView(sampleTracks: tracks)
//                .listStyle(PlainListStyle())
//                .environmentObject(spotify)
//
//        }
//    }
//
//}
//


