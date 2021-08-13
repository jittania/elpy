import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI


/// Examples:
///
/// input field for any keyword user would like to include
/// input field for any keyword user would like to exclude (using NOT)

struct MiscCriteraView: View {
    
    @EnvironmentObject var spotify: Spotify
    @Binding var currentGenre: String
    @Binding var currentYear: String
    
    // init() { }
    
    
    var body: some View {
        Text("Current genre: \(self.currentGenre)")
        Text("Current year: \(self.currentYear)")
            .padding()
    }
}

//struct MiscCriteraView_Previews: PreviewProvider {
//    @State static var currentGenre: String = ""
//    @State static var currentYear: String = ""
//    
//    static var previews: some View {
//        MiscCriteraView(currentGenre: $currentGenre, currentYear: $currentYear)
//    }
//}
