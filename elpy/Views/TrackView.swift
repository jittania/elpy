import SwiftUI
import Combine
import SpotifyWebAPI

struct TrackView: View {
    
    @EnvironmentObject var spotify: Spotify
    
    @State var trackAlbum: String = ""
    @State var trackReleaseYear: Date?
    @State var trackGenres: [String]? = []
    
    @State private var playRequestCancellable: AnyCancellable? = nil
    @State private var getAlbumInfoCancellable: AnyCancellable? = nil
    @State private var getArtistInfoCancellable: AnyCancellable? = nil
    
    @State private var showDetails = false

    @State private var alert: AlertItem? = nil
    
    let track: Track
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    showDetails.toggle() // Using toggle here means user can tap same button to hide
                } label: {
                    Text("ⓘ")
                        .padding(2)
                }
                .padding()
                
                Button(action: playTrack) {
                    HStack {
                        Text(trackDisplayName())
                        Spacer()
                    }
                    // Ensure the hit box extends across the entire width of the frame.
                    // See https://bit.ly/2HqNk4S
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                .alert(item: $alert) { alert in
                    Alert(title: alert.title, message: alert.message)
                }
            }
            // The location of the following text is determined by the location
            // of this code block, regardless of location of button that toggles appearance
            if showDetails {
                Text(displayAlbumInfo())
                    .font(.caption)
                Text(displayArtistGenres())
                    .font(.caption)
            }
            
        } // Outermost VStack
        .onAppear {
            // Need to call these here because they change the view's state
            // Note that this will cause the API requests to be made only as each
            // track view gets loaded
            getAlbumInfo()
            getArtistInfo()
        }
    }
    
    // =======================================================================
    
    /// `track.album?.uri` gives album's URI from a `Track` object
    ///
    /// Gets an album via `spotify.api.album(album)`
    ///
    /// Parameters:
    /// - `album`: The URI for an album, type `SpotifyURIConvertible`
    ///
    /// Returns:  `Album` object, which has attributes
    /// -   `name`: type `String`
    /// -   `genres` : type `[String]`
    /// -   `releaseDate`: type `Date` -  see also `releaseDatePrecision`
    
    func getAlbumInfo() {
        let album = track.album?.uri
        self.getAlbumInfoCancellable = spotify.api.album(album!)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.alert = AlertItem(
                            title: "Unable to retrieve album details",
                            message: error.localizedDescription
                        )
                    }
                },
                receiveValue: { albumObject in
                    print("Album name: ", albumObject.name)
                    print("Year: ", albumObject.releaseDate as Any)
                    self.trackAlbum = albumObject.name
                    self.trackReleaseYear = albumObject.releaseDate!
                    
                }
            )
    }
    
    func getArtistInfo() {
        
        let artist = track.artists?.first?.uri
        self.getArtistInfoCancellable = spotify.api.artist(artist!)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.alert = AlertItem(
                            title: "Unable to retrieve genre details",
                            message: error.localizedDescription
                        )
                    }
                },
                receiveValue: { artistObject in
                    print("Artist genres: ", artistObject.genres as Any)
                    self.trackGenres = artistObject.genres
                }
            )
    }
    
    func displayAlbumInfo() -> String {

        var displayAlbumInfo = ""
        
        let albumName = self.trackAlbum
        
        let releaseYear = self.trackReleaseYear
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        let convReleaseYear = dateFormatter.string(from: releaseYear!)
        
        displayAlbumInfo = "\"\(albumName),\" \(convReleaseYear)"

        return displayAlbumInfo
    }
    
    func displayArtistGenres() -> String {
        
        var displayArtistGenres = "Genre:"
        let genres = self.trackGenres!
        
        if genres.isEmpty {
            displayArtistGenres = "Genre: None"
        } else {
            for genre in genres {
                let genreStr = " " + genre.capitalized + ","
                displayArtistGenres += genreStr
            }
            displayArtistGenres.removeLast() // gets rid of extra comma at end
        }
        
        return displayArtistGenres
    }
    
    // =======================================================================
    
    /// The display name for the track. E.g., "Eclipse - Pink Floyd".
    func trackDisplayName() -> String {
        var displayName = "\"\(track.name)\""
        if let artistName = track.artists?.first?.name {
            displayName += " - \(artistName)"
        }
        return displayName
    }
    
    func playTrack() {
        
        let alertTitle = "Couldn't Play \(track.name)"

        guard let trackURI = track.uri else {
            self.alert = AlertItem(
                title: alertTitle,
                message: "missing URI"
            )
            return
        }

        let playbackRequest: PlaybackRequest

        if let albumURI = track.album?.uri {
            // Play the track in the context of its album. Always prefer
            // providing a context; otherwise, the back and forwards buttons may
            // not work.
            playbackRequest = PlaybackRequest(
                context: .contextURI(albumURI),
                offset: .uri(trackURI)
            )
        }
        else {
            playbackRequest = PlaybackRequest(trackURI)
        }
        
        // By using a single cancellable rather than a collection of
        // cancellables, the previous request always gets cancelled when a new
        // request to play a track is made.
        self.playRequestCancellable =
            self.spotify.api.getAvailableDeviceThenPlay(playbackRequest)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.alert = AlertItem(
                            title: alertTitle,
                            message: error.localizedDescription
                        )
                    }
                })
        
    }
}

struct TrackView_Previews: PreviewProvider {
    
    static let tracks: [Track] = [
        .because, .comeTogether, .faces,
        .illWind, .odeToViceroy, .reckoner,
        .theEnd, .time
    ]

    static var previews: some View {
        List(tracks, id: \.id) { track in
            TrackView(track: track)
        }
        .environmentObject(Spotify())
    }
}

