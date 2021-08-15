import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct SeedGenresView: View {
    
    @EnvironmentObject var spotify: Spotify
//    @State private var isEditing = false
    
    @State var seedGenres: [String] = []
    
    init() { }
    
    var body: some View {
        Text("Select Seed Genres")
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)

        VStack {

            Text("Enter up to 5 seed genres")
            // ❗️ alert: must enter at least 1 genre
            
            HStack {
                Link("Click here", destination: URL(string: "https://gist.github.com/drumnation/91a789da6f17f2ee20db8f55382b6653")!)
                    .foregroundColor(.purple)
                Text("for a list of available seed genres")
            }
            
        Form {
            
        }
         
        }
        NavigationLink(
            "Next", destination: TrackAttributesView(seedGenres: self.$seedGenres)
        ) // ❗️  disable nav link unless at least 1 genre is entered
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
