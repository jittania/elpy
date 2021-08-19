import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct GenreSelectView: View {
    
    @EnvironmentObject var spotify: Spotify
    
    @State var currentGenre: String = ""
    
    // init() { }
    
    var body: some View {

        VStack {
            Text("Enter a genre for your search, or leave empty to skip.")
                .font(.system(size: 20))
                .padding()
            VStack {
                Text("Not sure what to enter?")
                HStack {
                    Link("Click here", destination: URL(string: "https://everynoise.com/genrewords.html")!)
                        .foregroundColor(Color(#colorLiteral(red: 0.6786135959, green: 0.2310954848, blue: 1, alpha: 1)))
                    Text("for a complete")
                }
                Text("list of Spotify genres")
            }
            .padding()
            .foregroundColor(.secondary)
            
            genreInputBar
                .padding([.top, .horizontal])
                
            Spacer()
            NavigationLink(
                "Next", destination: YearSelectView(currentGenre: self.$currentGenre)
            )
            .font(.system(size: 22))
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 3)
                )
        }
        .navigationTitle("Genre Name")
    }
    
    var genreInputBar: some View {
        
        TextField("Genre name", text: $currentGenre)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(.purple)
            .padding(.leading, 22)
            .overlay(
                HStack {
                    Spacer()
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
