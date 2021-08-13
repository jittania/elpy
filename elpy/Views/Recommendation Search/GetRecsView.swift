import Foundation
import SwiftUI
import SpotifyWebAPI
import Combine

struct GetRecsView: View {

    @EnvironmentObject var spotify: Spotify
    
    @State private var isSearching = false
    
    @State var tracks: [Track] = []
    @State var trackURIs: [String] = []
    
//    @Binding var danceability: AttributeRange<Double>


    @State private var alert: AlertItem? = nil
    
    @State private var searchCancellable: AnyCancellable? = nil
   
//    / Used by the preview provider to provide sample data.
//    fileprivate init(sampleTracks: [Track]) {
//        self._tracks = State(initialValue: sampleTracks)
//    }
    
    init() { }
    
    var body: some View {
        VStack {
            Button("B U I L D!") {
//                print("Build crate command initiated with following criteria:")
//                print("Genre: \(self.currentGenre)")
//                print("Release year or range: \(self.currentYear)")
//                print("Text to include: \(self.currentIncludeText)")
//                print("Text to exclude: \(self.currentExcludeText)")
                getTrackRecs()
            }
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            Text("Tap a track to play it")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("Scroll down to save crate as playlist")
                .font(.caption)
                .foregroundColor(.secondary)
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
                    Text("Your search yielded no results!")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
            else {
                List {
                    ForEach(tracks, id: \.self) { track in
                        TrackView(track: track)
                    }
                }
            }
            Spacer()
            NavigationLink(
                "Save crate as playlist", destination: CreatePlaylistView(trackURIs: self.$trackURIs)
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            NavigationLink(
                "Try again!", destination: TrackAttributesView()
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            NavigationLink(
                "Go back to main nav", destination: MainNavigationView()
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
        }
        .navigationTitle("Build a crate!")
        .alert(item: $alert) { alert in
            Alert(title: alert.title, message: alert.message)
        }
    }
    
    
    
    /// Performs a search for recommended tracks based on `TrackAttributes`.
    /// Successful response ->  Array[Track] saved to `self.tracks`
    
    // Correct: "https://api.spotify.com/v1/recommendations?limit=20&seed_genres=classical%2Ccountry&target_energy=0.43&target_popularity=20&target_valence=0.3"
    
    // Actual:
    
//    func recommendations(
//        _ trackAttributes: TrackAttributes,
//        limit: Int? = nil,
//        market: String? = nil
//    ) -> AnyPublisher<RecommendationsResponse, Error>
    
    func getTrackRecs() {
        
        self.tracks = []
        self.trackURIs = []
        
        let trackAttributesObj = TrackAttributes(
            seedGenres: ["classical", "country"],
            energy: .init(target: 0.43),
            popularity: .init(target: 20),
            valence: .init(target: 0.3)
        )
        
        //if self.searchText.isEmpty { return }
        
//        print("searching with following Track Attributes:")
//        print("Danceability: ", trackAttributesObj.danceability ?? 0.5)
//        print("Popularity: ", trackAttributesObj.popularity ?? 50)
        
        self.isSearching = true
        
        self.searchCancellable = spotify.api.recommendations(
            trackAttributesObj,
            limit: 20
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


