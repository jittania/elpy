import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI


/// Examples:
///
/// input field for any keyword user would like to include
/// input field for any keyword user would like to exclude (using NOT)

struct MiscSearchCriteraView: View {
    
    @EnvironmentObject var spotify: Spotify
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct MiscSearchCriteraView_Previews: PreviewProvider {
    static var previews: some View {
        MiscSearchCriteraView()
    }
}
