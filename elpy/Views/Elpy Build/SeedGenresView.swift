import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct SeedGenresView: View {
    @EnvironmentObject var spotify: Spotify
    
    @State var seedGenres: [String] = []
    
    @State private var selectedGenreOne = "acoustic"
    @State private var selectedGenreTwo = "---"
    @State private var selectedGenreThree = "---"
    
    let defaultGenreSeedsReq = [
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
    
    let defaultGenreSeedsOptional = [
        "---",
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
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    var body: some View {
        ///  Note: Because pickers in forms have this navigation behavior, it’s important you present them in a
        ///  NavigationView on iOS otherwise you’ll find that tapping them doesn’t work.
        VStack {
            Form {
                Text("Select between 1 and 3 seed genres.")
                    .font(.system(size: 20))
                    .padding()
                Text("Elpy will use your selections to recommend tracks with similar styles")
                    .foregroundColor(.secondary)
                    .padding()
                
                Section {
                    Picker("First Genre:", selection: $selectedGenreOne) {
                       ForEach(defaultGenreSeedsReq, id: \.self) {
                           Text($0)
                       }
                   }
                   .pickerStyle(WheelPickerStyle())
                    //.background(Color.secondary)
                }
                Section {
                    Picker("Second Genre:", selection: $selectedGenreTwo) {
                       ForEach(defaultGenreSeedsOptional, id: \.self) {
                           Text($0)
                       }
                   }
                   .pickerStyle(WheelPickerStyle())
                    //.background(Color.secondary)
                }
                Section {
                    Picker("Third Genre:", selection: $selectedGenreThree) {
                       ForEach(defaultGenreSeedsOptional, id: \.self) {
                           Text($0)
                       }
                   }
                   .pickerStyle(WheelPickerStyle())
                    //.background(Color.secondary)
                }

                
            } // Form
            .background(Color.clear)
            
            NavigationLink(
                "Next",
                destination: TrackAttributesView(
                    seedGenres: self.$seedGenres).onAppear {
                        createArrFromSelections()
                    }
            )
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        } // VStack
        .navigationTitle("Seed Genres")
       
    } // body
    
    func createArrFromSelections() {
        // need to reset genreSeeds every time user clicks button
        self.seedGenres = []
        
        // only save genre picks if not equal to "---"
        let firstGenrePick = self.selectedGenreOne
        var secondGenrePick: String?
        var thirdGenrePick: String?
        
        if self.selectedGenreTwo != "---" && self.selectedGenreTwo != firstGenrePick {
            secondGenrePick = self.selectedGenreTwo
        }
        if self.selectedGenreThree != "---" && self.selectedGenreThree != firstGenrePick && self.selectedGenreThree != self.selectedGenreTwo {
            thirdGenrePick = self.selectedGenreThree
        }
        
        // only add genre picks to array if not nil and if not already in arr
        self.seedGenres.append(firstGenrePick)
        
        if secondGenrePick != nil {
            self.seedGenres.append(secondGenrePick!)
        }
        if thirdGenrePick != nil {
            self.seedGenres.append(thirdGenrePick!)
        }
        
        print("Logging selected genres: ", self.seedGenres)
    }
}
    

//struct SeedGenresView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeedGenresView
//    }
//}
