import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct GenreSelectView: View {
    
    @EnvironmentObject var spotify: Spotify
    
    @State var currentGenre: String = ""
    
    init() { }
    
    
    var body: some View {
        VStack {
            genreInputBar
                .padding([.top, .horizontal])
            Spacer()
            NavigationLink(
                "N E X T", destination: YearSelectView(currentGenre: self.$currentGenre)
            )
        }
        .navigationTitle("Select a genre")
    }
    
    var genreInputBar: some View {
        
        TextField("Genre name", text: $currentGenre)
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
