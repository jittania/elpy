import Foundation
import SwiftUI

struct TestTrackListView: View {
    
    @EnvironmentObject var spotify: Spotify
    
    // 1
    @ObservedObject var viewModel = TrackViewModel()
    
    var body: some View {
        
        Text("MISSY TRAX")
            .fontWeight(.bold)
            .font(.title)
        
        List(viewModel.tracks) { track in // 2
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("♦️")
                        Text(track.trackTitle) // 3a
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

// This structure declares a preview for the above structure's view:
struct TestTrackListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
