import SwiftUI

struct MainNavigationView: View {
    
    var body: some View {
        
        List {
            
            NavigationLink(
                "Manage Playlists", destination: PlaylistsListView()
            )
            NavigationLink(
                "See Recently Played Tracks", destination: RecentlyPlayedView()
            )
            NavigationLink(
                "Debug Menu", destination: DebugMenuView()
            )
            NavigationLink(
                "Build a crate!", destination: BuildCrateView()
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

