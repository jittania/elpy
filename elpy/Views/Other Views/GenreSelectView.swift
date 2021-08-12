import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct GenreSelectView: View {
    
    @EnvironmentObject var spotify: Spotify
    
    var body: some View {
        Text("Enter a genre to search for")
            .padding()
    }
}

struct GenreSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSelectView()
    }
}
