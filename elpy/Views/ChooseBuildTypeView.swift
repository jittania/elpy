// ChooseBuiltTypeView

import Foundation
import SwiftUI

struct ChooseBuildTypeView: View {
    
    var body: some View {
        
        Text("From here, you can either build a crate from a selective search of tracks, or get Elpy's help to build a crate of recommended tracks:")
            .padding()
        
        List {
            
            NavigationLink(
                "Filtered Track Search", destination: GenreSelectView()
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            NavigationLink(
                "Get Recommended Tracks", destination: SeedGenresView()
            )
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
         
        }
        .listStyle(PlainListStyle())
        
    }
}

//struct ChooseBuildTypeView_Previews: PreviewProvider {
//
//    static let spotify: Spotify = {
//        let spotify = Spotify()
//        spotify.isAuthorized = true
//        return spotify
//    }()
//
//    static var previews: some View {
//        NavigationView {
//            MainNavigationView()
//                .environmentObject(spotify)
//        }
//    }
//}
//
