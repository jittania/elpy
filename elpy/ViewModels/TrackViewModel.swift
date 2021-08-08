import Foundation
import Combine



class TrackViewModel: ObservableObject {
    
    @Published var tracks: [Track] = [] // 1
    var cancellationToken: AnyCancellable? // 2
    
    init() {
        loggingStuff()
        getTracks() // 3
        
        // print("Logging TrackViewModel.tracks:", self.tracks)
        print("================================")
        
    }
}

extension TrackViewModel {
    
    // Subscriber implementation
    func getTracks() {
        
        cancellationToken = SpotifyDB.request(.searchForTracks) // 4
            .mapError({ (error) -> Error in // 5
                print("🐸", error)
                return error
            })
            .sink(receiveCompletion: { _ in }, // 6
                  receiveValue: {
                    self.tracks = $0.tracks.items
                    print("I'm back in the TrackViewModel extension, this time in the subscriber code!")
                    print("7) Subscriber has received mapped data from operator")
                    print("================================")
                    // print("Logging TrackViewModel.tracks:", self.tracks)
            })
        print("I'm in the TrackViewModel extension because a request was made!")
    }
    
    func loggingStuff() {
        print("I'm in TrackViewModel!")
        print("1) An instance of TrackViewModel was created in ContentView")
        print("2) The subscriber (.sink in TrackViewModel) has made a request to the publisher")
        print("================================")
    }
}

// 1) The @Published property wrapper lets Swift know to keep an eye on any changes of this variable. If anything changes, the body in all views where this variable is used, will update.
// 2) Subscriber implementations can use this type to provide a “cancellation token” that makes it possible for a caller to cancel a publisher. Be aware that your network calls won’t work if you’re not assigning your call to a variable of this type.
// 3) Fetching the data as soon as the ViewModel is created
// 4) Begins request
// 5) Handle errors here
// 6) Here the actual subscriber is created. As mentioned earlier, the sink-subscriber comes with a closure, that lets us handle the received value when it’s ready from the publisher.
// 7) Assigns the received data to the tracks-property - this will trigger the action mentioned in step 1
