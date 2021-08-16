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
    
    // init() { }
    
    var body: some View {
        
        VStack {
            Text("To omit an attribute from your search, leave the slider position all the way to the left.")
                .padding()
            VStack{
                Text("Popularity: \(popularity, specifier: "%.f")")
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
                Text("Danceability: \(danceability, specifier: "%.2f")")
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
                Text("Instrumentalness: \(instrumentalness, specifier: "%.2f")")
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
                Text("Acousticness: \(acousticness, specifier: "%.2f")")
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
                Text("Valence: \(valence, specifier: "%.2f")")
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
