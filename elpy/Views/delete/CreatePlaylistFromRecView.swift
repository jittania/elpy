//import Foundation
//import SwiftUI
//import SpotifyWebAPI
//import Combine
//
//struct CreatePlaylistFromRecView: View {
//    
//    @EnvironmentObject var spotify: Spotify
//
//    @Binding var trackURIs: [String]  // 🐸 trackURIs from
//
//    @State private var isCreatingPlaylist = false
//    
//    @State var crateName: String = ""
//    
//    @State private var alert: AlertItem? = nil
//    
//    @State var newPlaylistURI: SpotifyURIConvertible = ""
//    
//    @State private var userInputPlaylistName  = ""
//    @State private var createPlaylistCancellable: AnyCancellable? = nil
//    @State private var addTracksCancellable: AnyCancellable? = nil
//    @State private var getPlaylistCancellable: AnyCancellable? = nil
//
//    
//    var body: some View {
//        VStack {
//            playlistNameBar
//                .padding([.top, .horizontal])
//            Spacer()
//            if crateName.isEmpty {
//                if isCreatingPlaylist {
//                    HStack {
//                        ProgressView()
//                            .padding()
//                        Text("Creating")
//                            .font(.title)
//                            .foregroundColor(.secondary)
//                    }
//                    
//                }
//                else {
//                    Text("Press enter to create playlist")
//                        .font(.title)
//                        .foregroundColor(.secondary)
//                }
//            }
//            Spacer()
//            NavigationLink(
//                "Build new recommendations crate", destination: TrackAttributesView()
//            )
//            .padding()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.black, lineWidth: 2)
//                    )
//            NavigationLink(
//                "Go back to main nav", destination: MainNavigationView()
//            )
//            .padding()
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.black, lineWidth: 2)
//                    )
//        }
//        .navigationTitle("Create Playlist")
//        .alert(item: $alert) { alert in
//            Alert(title: alert.title, message: alert.message)
//        }
//    }
//    
//
//    var playlistNameBar: some View {
//        // `onCommit` is called when the user presses the return key.
//        TextField("Enter name", text: $userInputPlaylistName , onCommit: createPlaylistFromTracks)
//            .padding(.leading, 22)
//            .overlay(
//                HStack {
//                    Spacer()
//                    if !userInputPlaylistName .isEmpty {
//                        Button(action: {
//                            self.userInputPlaylistName  = ""
//                        }, label: {
//                            Image(systemName: "xmark.circle.fill")
//                                .foregroundColor(.secondary)
//                        })
//                    }
//                }
//            )
//            .padding(.vertical, 7)
//            .padding(.horizontal, 7)
//            .background(Color(.secondarySystemBackground))
//            .cornerRadius(10)
//    }
//    
//    // =======================================================================
//    /// Note: Question marks `?` after a type refer to Optionals , a way in Swift which lets you indicate the possibility that a value might be absent for any type at all, without the need for special constants
//    
//    /// Note: Double question mark `??` is a nil-coalescing operator. In plain terms, it is just a shorthand for saying != nil . First it checks if the the return value is nil, if NOT, then the left value is presented, and if it is nil then the right value is presented.
//    
//    /// Creates a playlist when this button is tapped using `self.newPlaylistName`and `spotify.api.createPlaylist`
//    ///
//    /// Parameters:
//    /// - `userURI`: The URI of a user, type: `SpotifyURIConvertible` mine = "9dbb9857b3a64456"
//    /// - `playlistDetails`: The details of the playlist (type: `PlaylistDetails` with `name `)
//    ///
//    /// Returns: The just-created playlist (type: `Playlist` with `uri`)
//  
//    
//    /// Add songs to same playlist using `trackURIs ` (passed in from `BuildCrateView`) and
//    /// `spotify.api.addToPlaylist`
//    ///
//    /// Parameters:
//    /// - `playlist`: set to `uri` of the newly created playlist, type: `SpotifyURIConvertible`
//    /// - `uris`: An Array of URIs for tracks/episodes, type: `[SpotifyURIConvertible]`
//    ///
//    /// Returns: `snapshot id`of the playlist - can be used to refresh playlists view elsewhere - can check if this is necessary (check if this gets done anyway when you navigate back to "manage playlists" view
//    
//
//    func getPlaylistDetails() {
//        
//        let playlist = self.newPlaylistURI
//        
//        self.getPlaylistCancellable = spotify.api.playlist(playlist)
//            .receive(on: RunLoop.main)
//            .sink(
//                receiveCompletion: { completion in
//                    print("received completion:", completion)
//                    if case .failure(let error) = completion {
//                        self.alert = AlertItem(
//                            title: "Unable to locate playlist!",
//                            message: error.localizedDescription
//                        )
//                    }
//                },
//                receiveValue: { playlistObject in
//                    let playlistItems: [PlaylistItem] = playlistObject.items.items.compactMap(\.item)
//                    print("New playlist '\(playlistObject.name)' successfully created with \(playlistItems.count) tracks")
//
//                }
//            )
//        
//    }
//    
//    func addTracksToCurrentPlaylist(playlistURI: SpotifyURIConvertible) {
//
//        let playlist = playlistURI
//        let uris = self.trackURIs
//        
//        self.addTracksCancellable = spotify.api.addToPlaylist(
//            playlist,
//            uris: uris
//        )
//        .receive(on: RunLoop.main)
//        .sink(
//            receiveCompletion: { completion in
//                print("received completion:", completion)
//                if case .failure(let error) = completion {
//                    self.alert = AlertItem(
//                        title: "Unable to add tracks to playlist!",
//                        message: error.localizedDescription
//                    )
//                }
//            },
//            receiveValue: { playlistSnapshotID in
//                print("received playlistSnapshotID:", playlistSnapshotID)
//                
//                getPlaylistDetails()
//            }
//        )
//    }
//    
//    func createPlaylistFromTracks() {
//        
//        self.crateName = ""
//        
//        if self.userInputPlaylistName .isEmpty { return }
//
//        print("searching with query '\(self.userInputPlaylistName )'")
//        self.isCreatingPlaylist = true
//        
//        let playlistDeets = PlaylistDetails(name: self.userInputPlaylistName )
//        print("playlistDeets:", playlistDeets)
//        
//        let currentUserURI = self.spotify.currentUser!.uri
//        
//        self.createPlaylistCancellable = spotify.api.createPlaylist(for: currentUserURI as SpotifyURIConvertible, playlistDeets
//        )
//        .receive(on: RunLoop.main)
//        .sink(
//            receiveCompletion: { completion in
//                self.isCreatingPlaylist = false
//                if case .failure(let error) = completion {
//                    self.alert = AlertItem(
//                        title: "Couldn't Perform Search",
//                        message: error.localizedDescription
//                    )
//                }
//            },
//
//            receiveValue: { newPlaylistFromCrate in
//                self.crateName = newPlaylistFromCrate.name
//                print("Newly created playlist name: \(self.crateName)")
//
//                self.newPlaylistURI = newPlaylistFromCrate.uri
//                
//                addTracksToCurrentPlaylist(playlistURI: newPlaylistURI)
//            }
//        )
//    }
//    
//}
//    
//    
////
////struct CreatePlaylistFromRecView_Previews: PreviewProvider {
////    @State static var trackURIs: [String] = []
////
////    static var previews: some View {
////        Group {
////            CreatePlaylistView(trackURIs: $trackURIs)
////
////        }
////    }
////}
