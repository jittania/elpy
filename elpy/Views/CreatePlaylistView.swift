import Foundation
import SwiftUI


struct CreatePlaylistView: View {

    @State var newPlaylistName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    TextField("Enter playlist name", text: $newPlaylistName)
                }
                Section {
                    Button(action: {
                        print("Perform an action here...")
                    }) {
                        Text("Create playlist")
                    }
                }
            }
            .navigationBarTitle("Save crate as playlist")
        }
    }
}
    
struct CreatePlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreatePlaylistView()
        }
    }
}
