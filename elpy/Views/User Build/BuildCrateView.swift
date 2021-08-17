import Foundation
import SwiftUI
import SpotifyWebAPI
import Combine

struct BuildCrateView: View {

    @EnvironmentObject var spotify: Spotify
    
    @State var tracks: [Track] = []
    @State var trackURIs: [String] = []
    
    @Binding var currentGenre: String
    @Binding var currentYear: String
    @Binding var currentIncludeText: String
    @Binding var currentExcludeText: String

    @State private var alert: AlertItem? = nil
    @State private var isSearching = false
    @State private var searchCancellable: AnyCancellable? = nil
    
    @State private var showingEmptySearchAlert = false
    
    var body: some View {
        
        Button("Build Crate!") {
            if self.currentGenre == "" && self.currentYear == "" && self.currentIncludeText == "" && self.currentExcludeText == "" {
                print("Cannot execute search because user did not enter any search critera")
                showingEmptySearchAlert = true
            } else {
                searchForTracks()
            }
        }
        .alert(isPresented: $showingEmptySearchAlert) {
            Alert(
                title: Text("Could Not Build Crate!"),
                message: Text("You must submit at least one search criteria"),
                dismissButton: .default(Text("Got it!")))
        }
        .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2))
        
        VStack {
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
                Text("Tap on a track to play it")
                    .foregroundColor(.secondary)
                Text("Press ⓘ for track details")
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
                "Start Over", destination: GenreSelectView()
            )
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
            NavigationLink(
                "Go Home", destination: MainNavigationView()
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

    
    /// Performs a search for tracks based on `queryString`.
    /// Successful response ->  Array[Track] saved to `self.tracks`

    func searchForTracks() {
        
        // resets the search
        self.tracks = []
        self.trackURIs = []
        var queryString: String = ""
        print("Query string should be empty: ", queryString)
        
        //==========================================

        // values will be received as "" or a string
        var queryCurrGenre: String
        var queryCurrYear: String
        var queryCurrIncludeText: String
        var queryCurrExcludeText: String
        
        // need to check if each value is empty string
        // if a value is not empty, add appropriate prefix to it and append to
        // query string; else leave out
        
        // Make sure that unnecessary string isn't left at end of querystring
        
        // if genre string contains spaces, add double quotation marks
        
        // queryString must contain elements in this order:
        // currentIncludeText + currentGenre + currentYear + currentExcludeText
        // and all characters must be lowercase except for NOT
        
        if self.currentIncludeText != "" {
            queryCurrIncludeText = self.currentIncludeText.lowercased()
            queryString += queryCurrIncludeText + " "
        }
        if self.currentGenre != "" {
            // if genre string contains spaces, add double quotation marks
            if self.currentGenre.contains(" ") {
                // add dbl quot marks
                self.currentGenre = "\"\(self.currentGenre)\""
            }
            
            queryCurrGenre = "genre:" + self.currentGenre.lowercased()
            queryString += queryCurrGenre + " "
        }
        if self.currentYear != "" {
            queryCurrYear = "year:" + self.currentYear
            queryString += queryCurrYear + " "
        }
        if self.currentExcludeText != "" {
            queryCurrExcludeText = "NOT " + self.currentExcludeText.lowercased()
            queryString += queryCurrExcludeText
        } else {
            queryString.removeLast()
        }
        
        print("Assembled lowercase query string: ", queryString)

        if queryString.isEmpty { return }

        print("searching with query '\(queryString)'")
        self.isSearching = true
        
        self.searchCancellable = spotify.api.search(
            query: queryString,
            categories: [.track],
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


//struct BuildCrateView_Previews: PreviewProvider {
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


