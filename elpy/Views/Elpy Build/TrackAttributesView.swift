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
            Text("Provide Elpy with descriptive information about the kind of tracks you're looking for.")
                .font(.system(size: 20))
                .padding()
            Text("To omit an attribute from your request, leave the slider position all the way to the left. Select ⓘ to learn how each index value is interpreted.")
                .foregroundColor(.secondary)
                .padding()

            
            VStack{
                HStack {
                    Button("ⓘ") {
                        showingPopulPopover = true
                    }
                    .popover(isPresented: $showingPopulPopover) {
                        Text("How is the Popularity index calculated?")
                        Text("The popularity of a track is a value between 0 and 100, with 100 being the most popular. The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are. Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past.")
                            .padding()
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
                        Text("How is the Danceability index calculcated?")
                        Text("'Danceability' describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable.")
                            .padding()
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
                        Text("How is the Instrumentalness index calculcated?")
                        Text("'Instrumentalness' predicts the vocal content of a track. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content.")
                            .padding()
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
                        Text("How is the Acousticness index calculcated?")
                        Text("'Acousticness' is a measure from 0.0 to 1.0 of whether the track is acoustic.")
                            .padding()
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
                        Text("How is the Valence index calculcated?")
                        Text("'Valence' is a measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more 'positive' (e.g. happy, cheerful, euphoric), while tracks with low valence sound more 'negative' (e.g. sad, depressed, angry).")
                            .padding()
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
        .navigationTitle("Features")
    } // body
}
    

//struct TrackAttributesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackAttributesView()
//    }
//}
