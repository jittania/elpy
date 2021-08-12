import Foundation
import SwiftUI
import SpotifyWebAPI
import Combine

struct BuildCrateView: View {

    @EnvironmentObject var spotify: Spotify
    
    @State private var isSearching = false
    
    @State var tracks: [Track] = []
    @State var trackURIs: [String] = []

    @State private var alert: AlertItem? = nil
    
    @State private var searchText = ""
    @State private var searchCancellable: AnyCancellable? = nil
    
    /// Used by the preview provider to provide sample data.
    fileprivate init(sampleTracks: [Track]) {
        self._tracks = State(initialValue: sampleTracks)
    }
    
    init() { }
    
    var body: some View {
        VStack {
            searchBar
                .padding([.top, .horizontal])
            Text("Here is the crate Elpy made for you! Now, you can...")
                //.font(.title)
                .foregroundColor(.secondary)
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
                    Text("No Results")
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
        }
        .navigationTitle("Build a crate!")
        .alert(item: $alert) { alert in
            Alert(title: alert.title, message: alert.message)
        }
    }
    
    var searchBar: some View {
        
        // `onCommit` is called when the user presses the return key.
        TextField("Search", text: $searchText, onCommit: searchForTracks)
            .padding(.leading, 22)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    Spacer()
                    if !searchText.isEmpty {
                        Button(action: {
                            self.searchText = ""
                            self.tracks = []
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        })
                    }
                }
            )
            .padding(.vertical, 7)
            .padding(.horizontal, 7)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
    }
    
    
    /// Performs a search for tracks based on `searchText`.
    /// Successful response ->  Array[Track] saved to `self.tracks`
    
    func searchForTracks() {

        self.tracks = []
        self.trackURIs = []
        
        if self.searchText.isEmpty { return }

        print("searching with query '\(self.searchText)'")
        self.isSearching = true
        
        self.searchCancellable = spotify.api.search(
            query: self.searchText, categories: [.track]
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
            receiveValue: { searchResults in
               
                self.tracks = searchResults.tracks?.items ?? []

                for track in self.tracks {
                    self.trackURIs.append(track.uri!)
                }
                
                print(self.trackURIs)
                print("Request for \(self.tracks.count) tracks received!")
            }
        )
    }
    
}


struct BuildCrateView_Previews: PreviewProvider {
    
    static let spotify = Spotify()
    
    static let tracks: [Track] = [
        .because, .comeTogether, .odeToViceroy, .illWind,
        .faces, .theEnd, .time, .theEnd, .reckoner
    ]

    static var previews: some View {
        NavigationView {
            BuildCrateView(sampleTracks: tracks)
                .listStyle(PlainListStyle())
                .environmentObject(spotify)

        }
    }
    
}



