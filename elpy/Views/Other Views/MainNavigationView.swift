import SwiftUI

struct MainNavigationView: View {
    
    var body: some View {
        
        Text("Welcome to Elpy!")
        
        Text("Elpy is a music discovery tool that builds a 'crate' of new songs for you, just like in the olden days when people went to record stores to dig up new finds. Except for Elpy has access to Spotify's entire database of tracks!")
            .padding()
        
        Text("From here, you can check out your current Spotify library, view recently played tracks, or get started building crates with Elpy:")
            .padding()
        
        List {
            
            NavigationLink(
                "View Playlists", destination: PlaylistsListView()
            )
            NavigationLink(
                "View Recently Played Tracks", destination: RecentlyPlayedView()
            )
//            NavigationLink(
//                "🐞", destination: DebugMenuView()
//            )
            NavigationLink(
                "Build me some crates!", destination: GenreSelectView()
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

