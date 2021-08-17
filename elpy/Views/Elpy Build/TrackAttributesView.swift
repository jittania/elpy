import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI


struct TrackAttributesView: View {
    
    @EnvironmentObject var spotify: Spotify
    @State private var isEditing = false
    
    @Binding var seedGenres: [String]
    
    @State var popularity: Double = 0
    @State var danceability: Double = 0
    @State var instrumentalness: Double = 0
    @State var acousticness: Double = 0
    @State var valence: Double = 0
  
    @State private var showingPopulPopover = false
    @State private var showingDancePopover = false
    @State private var showingInstrPopover = false
    @State private var showingAcousPopover = false
    @State private var showingValenPopover = false
 

    
    var body: some View {
    
        VStack {
            Text("To omit an attribute from your search, leave the slider position all the way to the left.")
                .padding()
            
            VStack{
                HStack {
                    Button("ⓘ") {
                        showingPopulPopover = true
                    }
                    .popover(isPresented: $showingPopulPopover) {
                       Text(
                        """
                        The popularity of a track is a value between 0 and 100, with 100 being the most popular. The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are.
                        Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past.
                        """
                       )
                    }
                    Text("Popularity: \(popularity, specifier: "%.f")")
                }
                HStack {
                    Text("Skip")
                    Slider(
                        value: $popularity,
                        in:0...100,
                        step: 5,
                        onEditingChanged: { editing in
                            isEditing = editing
                    })
                        .accentColor(Color.blue)
                    Text("100")
                }
            }.padding()
            VStack{
                HStack {
                    Button("ⓘ") {
                        showingDancePopover = true
                    }
                    .popover(isPresented: $showingDancePopover) {
                       Text(
                        """
                        Danceability: Describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable.
                        """
                       )
                    }
                    Text("Danceability: \(danceability, specifier: "%.2f")")
                }
                HStack {
                    Text("Skip")
                    Slider(
                        value: $danceability,
                        in:0...1.00,
                        step: 0.05,
                        onEditingChanged: { editing in
                            isEditing = editing
                    })
                        .accentColor(Color.blue)
                    Text("1")
                }
            }.padding()
            VStack{
                HStack {
                    Button("ⓘ") {
                        showingInstrPopover = true
                    }
                    .popover(isPresented: $showingInstrPopover) {
                       Text(
                        """
                        Instrumentalness: Predicts whether a track contains no vocals. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content.
                        """
                       )
                    }
                    Text("Instrumentalness: \(instrumentalness, specifier: "%.2f")")
                }
               
                HStack {
                    Text("Skip")
                    Slider(
                        value: $instrumentalness,
                        in:0...1.00,
                        step: 0.05,
                        onEditingChanged: { editing in
                            isEditing = editing
                    })
                        .accentColor(Color.blue)
                    Text("1")
                }
            }.padding()
            VStack{
                HStack {
                    Button("ⓘ") {
                        showingAcousPopover = true
                    }
                    .popover(isPresented: $showingAcousPopover) {
                       Text(
                        """
                        Acousticness: A measure from 0.0 to 1.0 of whether the track is acoustic.
                        """
                       )
                    }
                    Text("Acousticness: \(acousticness, specifier: "%.2f")")
                }
                
                HStack {
                    Text("Skip")
                    Slider(
                        value: $acousticness,
                        in:0...1.00,
                        step: 0.05,
                        onEditingChanged: { editing in
                            isEditing = editing
                    })
                        .accentColor(Color.blue)
                    Text("1")
                }
            }.padding()
            VStack{
                HStack {
                    Button("ⓘ") {
                        showingValenPopover = true
                    }
                    .popover(isPresented: $showingValenPopover) {
                       Text(
                        """
                        Valence: A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry).
                        """
                       )
                    }
                    Text("Valence: \(valence, specifier: "%.2f")")
                }
                HStack {
                    Text("Skip")
                    Slider(
                        value: $valence,
                        in:0...1.00,
                        step: 0.05,
                        onEditingChanged: { editing in
                            isEditing = editing
                    })
                        .accentColor(Color.blue)
                    Text("1")
                }
            }.padding()
        NavigationLink(
            "Next", destination: GetRecsView(
                seedGenres: self.$seedGenres,
                popularity: self.$popularity,
                danceability: self.$danceability,
                instrumentalness: self.$instrumentalness,
                acousticness: self.$acousticness,
                valence: self.$valence
                )
        )
        .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
        } // VStack
        .navigationTitle("Audio Features")
    } // body
}
    

//struct TrackAttributesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackAttributesView()
//    }
//}
