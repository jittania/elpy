import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct TrackAttributesView: View {
    
    @EnvironmentObject var spotify: Spotify
    
//    @State var seedGenres: [String]? = []
//    @State var danceability: AttributeRange<Double> = .init(target: 0.0)
//    @State var popularity: AttributeRange<Int> = .init(target: 0)
    
    init() { }
    
    
    var body: some View {
        Text("Enter up to 5 seed genres separated by commas")
            .padding()
        HStack {
            Link("Click here", destination: URL(string: "https://gist.github.com/drumnation/91a789da6f17f2ee20db8f55382b6653")!)
                .foregroundColor(.red)
            Text("for a list of available seed genres")
        }
        Text("Enter a popularity ranking between 0 and 100")
            .padding()
        Text("Enter a danceability rating between 0.0 and 1.0")
            .padding()
        Text("Enter an instrumentalness rating between 0.0 and 1.0")
            .padding()
        Text("Enter an acousticness rating between 0.0 and 1.0")
            .padding()
        Text("Enter a valence rating between 0.0 and 1.0")
            .padding()
        NavigationLink(
            "N E X T", destination: GetRecsView()
        )
        .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        .navigationTitle("Track Attributes")
    }
 
}
    
    

//struct TrackAttributesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackAttributesView()
//    }
//}
