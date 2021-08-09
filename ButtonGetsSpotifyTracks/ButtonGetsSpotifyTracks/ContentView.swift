//
//  ContentView.swift
//  ButtonGetsSpotifyTracks
//
//  Created by Jittania Smith on 8/4/21.
//

import SwiftUI

struct ContentView: View {
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

// 1) We add the @ObservedObject property wrapper, to let our app know, what we need to observe for any changes in the viewModel property.
// 2) We give our List the array of tracks that we are going to fetch together with Combine. This will later be the part that automatically updates the list, when the data is added to the tracks-array.
// 3a+b: We add the track’s title and id to a Text-object.
