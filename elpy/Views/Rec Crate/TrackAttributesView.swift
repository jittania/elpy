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
        Text("Select Audio Features")
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
        
        Text("To ommit an attribute from your search, leave the slider position all the way to the left")
        
        VStack {
            VStack{
                Text("Popularity:")
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
                Text("Current: \(popularity, specifier: "%.f")")
            }.padding()

            VStack{
                Text("Danceability:")
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
                Text("Current: \(danceability, specifier: "%.2f")")
            }
            
            VStack{
                Text("Instrumentalness:")
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
                Text("Current: \(instrumentalness, specifier: "%.2f")")
            }
               
            
            VStack{
                Text("Acousticness:")
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
                Text("Current: \(acousticness, specifier: "%.2f")")
            }
            
                
            VStack{
                Text("Valence:")
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
                Text("Current: \(valence, specifier: "%.2f")")
            }
        }
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
    }
 
}
    

//struct TrackAttributesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackAttributesView()
//    }
//}
