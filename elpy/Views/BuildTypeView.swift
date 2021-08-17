// ChooseBuiltTypeView

import Foundation
import SwiftUI

struct ChooseBuildTypeView: View {
    
    var body: some View {
        VStack {
            Text("From here, you can either build your own crate from a selective search of tracks, or ask Elpy to recommend tracks for you:")
                .padding()

            List {
                NavigationLink(
                    "Build My Own", destination: GenreSelectView()
                )
                .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                NavigationLink(
                    "Let Elpy Build", destination: SeedGenresView()
                )
                .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Build Type")
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
