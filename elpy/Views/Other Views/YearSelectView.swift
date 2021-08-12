import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct YearSelectView: View {
    
    @EnvironmentObject var spotify: Spotify
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct YearSelectView_Previews: PreviewProvider {
    static var previews: some View {
        YearSelectView()
    }
}
