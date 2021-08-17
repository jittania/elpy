import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct MiscCriteraView: View {
    
    @EnvironmentObject var spotify: Spotify
    @Binding var currentGenre: String
    @Binding var currentYear: String
    
    @State var currentIncludeText: String = ""
    @State var currentExcludeText: String = ""
    
    // init() { }
    
    var body: some View {
        VStack {
            Text("Enter any text you wish to include or exclude in your search, or leave empty to skip.")
                .padding()
            Text("Elpy will check for these keywords in the track's name, album title, and artist fields")
                .padding()
                .font(.caption)
            
            includeCriteriaBar
                .padding([.top, .horizontal])

            excludeCriteriaBar
                .padding([.top, .horizontal])
            
            Spacer()
            NavigationLink(
                "Next", destination: BuildCrateView(
                    currentGenre: self.$currentGenre,
                    currentYear: self.$currentYear,
                    currentIncludeText: self.$currentIncludeText,
                    currentExcludeText: self.$currentExcludeText
                ) // important for these to be in the same order as they are in the view, or else Xcode...crashes?
            )
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
        .navigationTitle("Keywords")
    }
    
    var includeCriteriaBar: some View {
        
        TextField("Text to include", text: $currentIncludeText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.leading, 22)
            .overlay(
                HStack {
                    if !currentIncludeText.isEmpty {
                        Button(action: {
                            self.currentIncludeText = ""
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
    
    var excludeCriteriaBar: some View {
        
        TextField("Text to exclude", text: $currentExcludeText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.leading, 22)
            .overlay(
                HStack {
                    if !currentExcludeText.isEmpty {
                        Button(action: {
                            self.currentExcludeText = ""
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

//struct MiscCriteraView_Previews: PreviewProvider {
//    @State static var currentGenre: String = ""
//    @State static var currentYear: String = ""
//    
//    static var previews: some View {
//        MiscCriteraView(currentGenre: $currentGenre, currentYear: $currentYear)
//    }
//}
