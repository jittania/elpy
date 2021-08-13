import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct TrackAttributesView: View {
    
    @EnvironmentObject var spotify: Spotify
    
//    @State var danceability: AttributeRange<Double>
//    @State var popularity: AttributeRange<Int>
    
    init() { }
    
    
    var body: some View {
        VStack {
            
//            NavigationLink(
//                "N E X T", destination: GetRecsView(danceability: self.$danceability, popularity: self.$popularity)
//            )
            NavigationLink(
                "N E X T", destination: GetRecsView()
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
        }
        .navigationTitle("Track Attributes")
    }
    
    

}
    
    

//struct TrackAttributesView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackAttributesView()
//    }
//}
