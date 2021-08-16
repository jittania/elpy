import Foundation
import SwiftUI
import Combine
import SpotifyWebAPI

struct YearSelectView: View {
    
    @EnvironmentObject var spotify: Spotify
    @Binding var currentGenre: String
    
    @State private var showingInvalidYearAlert = false
    @State var currentYear: String = ""

//    init() { }
     
    var body: some View {
        Text("Select Release Year")
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
        VStack {
            Text("Can either enter a single year, or a range of years separated by a dash e.g. '1980-1989'")
            yearInputBar
                .padding([.top, .horizontal])
            NavigationLink(
                "Next",
                destination:
                    MiscCriteraView(
                        currentGenre: self.$currentGenre,
                        currentYear: self.$currentYear
                    ).onAppear {
                        if self.checkYearInput() {
                            showingInvalidYearAlert = true
                        }
                    }
            )
            .alert(isPresented: $showingInvalidYearAlert) {
                Alert(
                    title: Text("Invalid Entry!"),
                    message: Text("Must enter single year (XXXX), or a range of years (XXXX-XXXX) without spaces"),
                    dismissButton: .default(Text("Go Back"))
                )
            }
            .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
        } // VStack
        
    }
    
    var yearInputBar: some View {
        
        TextField("Year", text: $currentYear)
            .textFieldStyle(RoundedBorderTextFieldStyle())
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
    } // yearInputBar
    
    func checkYearInput() -> Bool {
        if self.currentYear.contains(" ") || self.currentYear.count > 9 {
            return true
        } else {
            return false
        }
    }
    

} // var body


//struct YearSelectView_Previews: PreviewProvider {
//    @State static var currentGenre: String = ""
//    
//    static var previews: some View {
//        YearSelectView(currentGenre: $currentGenre)
//    }
//}
