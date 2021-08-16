import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct GenreSelectView: View {
    
    @EnvironmentObject var spotify: Spotify
    
    @State var currentGenre: String = ""
    
    // init() { }
    
    var body: some View {
        Text("Select Genre")
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
        VStack {
            Text("Not sure what to enter?")
            HStack {
                Link("Click here", destination: URL(string: "https://everynoise.com/genrewords.html")!)
                    .foregroundColor(.red)
                Text("for a complete list of Spotify genres")
            }
            genreInputBar
                .padding([.top, .horizontal])
            NavigationLink(
                "Next", destination: YearSelectView(currentGenre: self.$currentGenre)
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
        }
    }
    
    var genreInputBar: some View {
        
        TextField("Genre name", text: $currentGenre)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.leading, 22)
            .overlay(
                HStack {
                    if !currentGenre.isEmpty {
                        Button(action: {
                            self.currentGenre = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        })
                    }
                }
            )
            .padding(.vertical, 7)
            .padding(.horizontal, 7)
    }

}
    
    

//struct GenreSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenreSelectView()
//    }
//}