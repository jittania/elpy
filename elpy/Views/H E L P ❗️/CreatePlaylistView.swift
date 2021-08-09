import Foundation
import SwiftUI


struct CreatePlaylistView: View {
    
    @EnvironmentObject var spotify: Spotify

    @State var newPlaylistName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    TextField("Enter playlist name", text: $newPlaylistName)
                }
                
                Button(action: createPlaylistFromTracks, label: {
                    Text("Create Playlist")
                        .padding(10)
                })
                
            }
            .navigationBarTitle("Save crate as playlist!")
        }
    }
    
    func createPlaylistFromTracks() {
        
        // ❗️ ❗️ ❗️ ❗️ ❗️ ❗️ ❗️ ❗️
        /// Create a playlist when this button is tapped using `newPlaylistName`
        /// and `spotify.api.createPlaylist`
        /// Then add songs to same playlist using `trackURIs ` from `BuildCrateView` state (?)
        /// and `spotify.api.addToPlaylist`
        // ❗️ ❗️ ❗️ ❗️ ❗️ ❗️ ❗️ ❗️

    }
}
    
struct CreatePlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreatePlaylistView()
        }
    }
}
