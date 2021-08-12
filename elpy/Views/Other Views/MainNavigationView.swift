import SwiftUI

struct MainNavigationView: View {
    
    var body: some View {
        
        Text("Welcome to Elpy!")
        
        Text("Elpy is a music discovery tool that build a 'crate' of new songs for you, just like in the olden days when people went to record stores to dig in the crates. Except for Elsy has access to the entire Spotify database of songs.")
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
                "Build crates!", destination: BuildCrateView()
            )
            
            // This is the location where you can add your own views to test out
            // your application. Each view receives an instance of `Spotify`
            // from the environment.
            
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

