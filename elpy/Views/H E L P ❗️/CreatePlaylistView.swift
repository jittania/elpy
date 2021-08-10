import Foundation
import SwiftUI
import SpotifyWebAPI
import Combine

struct CreatePlaylistView: View {
    
    @EnvironmentObject var spotify: Spotify

    // @Binding var trackURIs: [String]  // 🐸 trackURIs from BuildCrateView

    @State private var isSearching = false
    
    @State var crateName: String = ""

    @State private var alert: AlertItem? = nil
    
    @State private var searchText = ""
    @State private var searchCancellable: AnyCancellable? = nil

    init() { }
    
    var body: some View {
        VStack {
            searchBar
                .padding([.top, .horizontal])
//            Text("Tap on a track to play it.")
//                .font(.caption)
//                .foregroundColor(.secondary)
            Spacer()
            if crateName.isEmpty {
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
                    Text("Press enter to create playlist")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
            else {
                Text("Delete this text")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .navigationTitle("Create Playlist 🐸")
        .alert(item: $alert) { alert in
            Alert(title: alert.title, message: alert.message)
        }
    }
    
    /// A search bar. Essentially a textfield with a magnifying glass and an "x"
    /// button overlayed in front of it.
    var searchBar: some View {
        // `onCommit` is called when the user presses the return key.
        TextField("Enter name", text: $searchText, onCommit: createPlaylistFromTracks)
            .padding(.leading, 22)
            .overlay(
                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.secondary)
                    Spacer()
                    if !searchText.isEmpty {
                        // Clear the search text when the user taps the "x"
                        // button.
                        Button(action: {
                            self.searchText = ""
                            // self.tracks = []
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
    
    // =======================================================================
    
    /// Note: Question marks `?` after a type refer to Optionals , a way in Swift which lets you indicate the possibility that a value might be absent for any type at all, without the need for special constants
    
    /// Note: Double question mark `??` is a nil-coalescing operator. In plain terms, it is just a shorthand for saying != nil . First it checks if the the return value is nil, if NOT, then the left value is presented, and if it is nil then the right value is presented.
    
    /// Creates a playlist when this button is tapped using `self.newPlaylistName`and `spotify.api.createPlaylist`
    ///
    /// Parameters:
    /// - `userURI`: The URI of a user, type: `SpotifyURIConvertible` mine = "9dbb9857b3a64456"
    /// - `playlistDetails`: The details of the playlist (type: `PlaylistDetails` with `name `)
    ///
    /// Returns: The just-created playlist (type: `Playlist` with `uri`)
  
    
    /// Add songs to same playlist using `trackURIs ` (passed in from `BuildCrateView`) and
    /// `spotify.api.addToPlaylist`
    ///
    /// Parameters:
    /// - `playlist`: set to `uri` of the newly created playlist, type: `SpotifyURIConvertible`
    /// - `uris`: An Array of URIs for tracks/episodes, type: `[SpotifyURIConvertible]`
    ///
    /// Returns: `snapshot id`of the playlist - can be used to refresh playlists view elsewhere - can check if this is necessary (check if this gets done anyway when you navigate back to "manage playlists" view

    func createPlaylistFromTracks() {
        
        // print("🌴 Track URIS:", self.trackURIs)
        // =======================================================================

        self.crateName = ""
        
        if self.searchText.isEmpty { return }

        print("searching with query '\(self.searchText)'")
        self.isSearching = true
        
        let playlistDeets = PlaylistDetails(name: self.searchText)
        print("playlistDeets:", playlistDeets)
        
        // let userURI = "spotify:user:74fb67fc80f24026"
        let currentUserURI = self.spotify.currentUser?.uri
        
        self.searchCancellable = spotify.api.createPlaylist(for: currentUserURI as! SpotifyURIConvertible, playlistDeets
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

            receiveValue: { newPlaylistFromCrate in
                self.crateName = newPlaylistFromCrate.name
                print("Newly created playlist name: \(self.crateName)")
            }
        )
    }
    
}
    
    
    
    
    

    
    

    
//struct CreatePlaylistView_Previews: PreviewProvider {
//    @State static var trackURIs: [String] = [] // 🐸
//
//    static var previews: some View {
//        Group {
//            CreatePlaylistView(trackURIs: $trackURIs) // 🐸
//
//        }
//    }
//}
