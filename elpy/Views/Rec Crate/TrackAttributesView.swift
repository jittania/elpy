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
        Text("Select Track Attributes")
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
        Text("Enter up to 5 seed genres separated by commas")
        HStack {
            Link("Click here", destination: URL(string: "https://gist.github.com/drumnation/91a789da6f17f2ee20db8f55382b6653")!)
                .foregroundColor(.red)
            Text("for a list of available seed genres")
        }
        Text("Enter a popularity ranking between 0 and 100")
        Text("Enter a danceability rating between 0.0 and 1.0")
           
        Text("Enter an instrumentalness rating between 0.0 and 1.0")
           
        Text("Enter an acousticness rating between 0.0 and 1.0")
            
        Text("Enter a valence rating between 0.0 and 1.0")
            
        NavigationLink(
            "Next", destination: GetRecsView()
        )
        .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
    }
 
}
    

struct TrackAttributesView_Previews: PreviewProvider {
    static var previews: some View {
        TrackAttributesView()
    }
}
