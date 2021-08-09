import SwiftUI
import Combine
import SpotifyWebAPI

@main
struct Elpy: App {

    @StateObject var spotify = Spotify()

    init() {
        SpotifyAPILogHandler.bootstrap()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(spotify)
        }
    }
    
}
