import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct SeedGenresView: View {
    
    @EnvironmentObject var spotify: Spotify
//    @State private var isEditing = false
    
    @State var seedGenres: [String] = []
    
    @State private var selectedGenreOne = "acoustic"
    @State private var selectedGenreTwo = "acoustic"
    @State private var selectedGenreThree = "acoustic"
    
    let defaultGenreSeeds = [
        "acoustic",
        "afrobeat",
        "alt-rock",
        "alternative",
        "ambient",
        "anime",
        "black-metal",
        "bluegrass",
        "blues",
        "bossanova",
        "brazil",
        "breakbeat",
        "british",
        "cantopop",
        "chicago-house",
        "children",
        "chill",
        "classical",
        "club",
        "comedy",
        "country",
        "dance",
        "dancehall",
        "death-metal",
        "deep-house",
        "detroit-techno",
        "disco",
        "disney",
        "drum-and-bass",
        "dub",
        "dubstep",
        "edm",
        "electro",
        "electronic",
        "emo",
        "folk",
        "forro",
        "french",
        "funk",
        "garage",
        "german",
        "gospel",
        "goth",
        "grindcore",
        "groove",
        "grunge",
        "guitar",
        "happy",
        "hard-rock",
        "hardcore",
        "hardstyle",
        "heavy-metal",
        "hip-hop",
        "holidays",
        "honky-tonk",
        "house",
        "idm",
        "indian",
        "indie",
        "indie-pop",
        "industrial",
        "iranian",
        "j-dance",
        "j-idol",
        "j-pop",
        "j-rock",
        "jazz",
        "k-pop",
        "kids",
        "latin",
        "latino",
        "malay",
        "mandopop",
        "metal",
        "metal-misc",
        "metalcore",
        "minimal-techno",
        "movies",
        "mpb",
        "new-age",
        "new-release",
        "opera",
        "pagode",
        "party",
        "philippines-opm",
        "piano",
        "pop",
        "pop-film",
        "post-dubstep",
        "power-pop",
        "progressive-house",
        "psych-rock",
        "punk",
        "punk-rock",
        "r-n-b",
        "rainy-day",
        "reggae",
        "reggaeton",
        "road-trip",
        "rock",
        "rock-n-roll",
        "rockabilly",
        "romance",
        "sad",
        "salsa",
        "samba",
        "sertanejo",
        "show-tunes",
        "singer-songwriter",
        "ska",
        "sleep",
        "songwriter",
        "soul",
        "soundtracks",
        "spanish",
        "study",
        "summer",
        "swedish",
        "synth-pop",
        "tango",
        "techno",
        "trance",
        "trip-hop",
        "turkish",
        "work-out",
        "world-music"
      ]
    
    init() { }
    
    var body: some View {

        ///  Note: Because pickers in forms have this navigation behavior, it’s important you present them in a
        ///  NavigationView on iOS otherwise you’ll find that tapping them doesn’t work.
        
        NavigationView {
            Text("Select Seed Genres")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Form {
                Section {
                    Text("Enter up to 3 seed genres")
            }
                
                Section {
                    Picker("First Genre:", selection: $selectedGenreOne) {
                       ForEach(defaultGenreSeeds, id: \.self) {
                           Text($0)
                       }
                   }
                   .pickerStyle(WheelPickerStyle())
                }
                
                Section {
                    Picker("Second Genre:", selection: $selectedGenreTwo) {
                       ForEach(defaultGenreSeeds, id: \.self) {
                           Text($0)
                       }
                   }
                   .pickerStyle(WheelPickerStyle())
                }
                
                Section {
                    Picker("Third Genre:", selection: $selectedGenreThree) {
                       ForEach(defaultGenreSeeds, id: \.self) {
                           Text($0)
                       }
                   }
                   .pickerStyle(WheelPickerStyle())
                }
            }
        }
        NavigationLink(
            "Next", destination: TrackAttributesView(seedGenres: self.$seedGenres)
        ) // ❗️  create disable var that checks length of seedGenres at >= 1
        .font(.title)
        .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
}
    

//struct SeedGenresView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeedGenresView
//    }
//}
