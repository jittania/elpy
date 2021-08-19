import Foundation
import SwiftUI

struct MainNavigationView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Elpy is a music discovery tool that builds 'crates' of new songs for you, emulating the experience of visiting an actual record store....Except that Elpy has access to Spotify's entire database of tracks!")
                .padding()
            Text("From here, you can check out your current Spotify library, view recently played tracks, or get started building crates with Elpy:")
                .padding()
        }
        .font(.system(size: 20))
        
        
        List {
            NavigationLink(
                "Playlist Library", destination: PlaylistsListView()
            )
            .font(.system(size: 22))
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3)
                )
            NavigationLink(
                "Recently Played Tracks", destination: RecentlyPlayedView()
            )
            .font(.system(size: 22))
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3)
                )
//            NavigationLink(
//                "🐞", destination: DebugMenuView()
//            )
            NavigationLink(
                "Build Crates", destination: ChooseBuildTypeView()
            )
            .font(.system(size: 22))
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3)
                )
        }
        .listStyle(PlainListStyle())
        
    }
}

struct ExamplesListView_Previews: PreviewProvider {
    
    static let spotify: Spotify = {
        let spotify = Spotify()
        spotify.isAuthorized = true
        return spotify
    }()
    
    static var previews: some View {
        NavigationView {
            MainNavigationView()
                .environmentObject(spotify)
        }
    }
}

