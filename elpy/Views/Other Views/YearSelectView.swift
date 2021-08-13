import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct YearSelectView: View {
    
    @EnvironmentObject var spotify: Spotify
    @Binding var currentGenre: String
    
    @State var currentYear: String = ""

//    init() { }
     
    var body: some View {
        VStack {
            Text("Can either enter a single year, or a range of years separated by a dash e.g. '1980-1989'")
            yearInputBar
                .padding([.top, .horizontal])
            NavigationLink(
                "N E X T", destination: MiscCriteraView(currentGenre: self.$currentGenre, currentYear: self.$currentYear) // important for these to be in the same order as they are in the view, or else Xcode...crashes?
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
        }
        .navigationTitle("Select a year")
    }
    
    var yearInputBar: some View {
        
        TextField("Year", text: $currentYear)
            .padding(.leading, 22)
            .overlay(
                HStack {
                    if !currentYear.isEmpty {
                        Button(action: {
                            self.currentYear = ""
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


//struct YearSelectView_Previews: PreviewProvider {
//    @State static var currentGenre: String = ""
//    
//    static var previews: some View {
//        YearSelectView(currentGenre: $currentGenre)
//    }
//}
