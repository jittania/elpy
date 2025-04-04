![logo3 copy](https://github.com/user-attachments/assets/a5a6a001-8503-4cd7-922e-eb2181a9c176)

# **Elpy**

One of Spotify's primary advantages is that it provides a central hub for musical collections across devices. It streamlines the process of actually getting music, organizing it, and storing it on multiple devices. This means users can devote more time to actually organizing and maintaining playlists. However, because of Spotify's limited search specifity, users can find themselves reliant on outside sources to find new music based on criteria like genre, release date, or charateristics of the song (BPM, energy level, instrumental nature).

What if there was a way to search directly in Spotify's database for songs based on specific search critera, the same way you might look for new LPs in a record store?

Elpy expands a Spotify user's ability to perform informed searches for new music, while learning about the music they discover. This iOS app is intended to augment and diversify the musical discovery experience provided by Spotify without compromising its advantage as a multi-device hub for your musical library.

---

## **Application Features**

1. User can employ Elpy to find new music and expand their existing Spotify library: user has full access to their personal Spotify library from within app: can create, modify, play playlists from app

![Screenshot 2025-03-13 at 6 22 40 PM](https://github.com/user-attachments/assets/c24e41d7-939a-44ed-9ae8-9f069dc963fc)
![Screenshot 2025-03-13 at 6 27 50 PM](https://github.com/user-attachments/assets/1b57e831-ca67-4ccb-9b1b-10a9b51d7dfa)

2. User has option to build an "informed" crate vs. letting Elpy build a crate. To build an "Informed" crate, user selects (has option to skip any, but must respond to at least one) :
   - Release date period
   - Genre (a complete list that responds to a "filter" input field that user can employ to narrow down genres)
   - Miscellaneous style criteria: Valence, Danceability, Obscurity, Instrumentalness, Acousticness, Energy, BPM
   - 
![Screenshot 2025-03-13 at 6 31 07 PM](https://github.com/user-attachments/assets/348d0c4c-394a-4623-b937-aad034ea1e58)
![Screenshot 2025-03-13 at 6 31 19 PM](https://github.com/user-attachments/assets/08857b03-c54c-4bc3-8586-57871210467c)

3. To let Elpy build a crate, user has option to choose style specifications, or let Elpy choose 20 songs at random

4. User is given a "crate" of songs (a Spotify playlist of 20 songs) based on their search choices
   - Songs are displayed in format of Track name : Artist: Release Year : Genre
   - User can play songs within the app, favorite individual songs, add songs to existing playlists, or save the entire Elpy crate as a playlist

---

## **Local Setup Instructions**

This version of the app currently requires Xcode to run. Go [here](https://developer.apple.com/support/xcode/) to find a version of Xcode that is compatible with your current OS.

1. `cd` into `elpy`

2. Ensure CocoaPods is installed on your system with `pod --version`. If not, install it using `sudo gem install cocoapods`

3. Install project dependencies with `pod install`

4. Open the Xcode Workspace file with `open elpy.xcworkspace`

5. Build and run the app:

- In Xcode, select your preferred simulator (e.g., iPhone 15).​
- Press `Cmd + R` or click the Run button to build and launch the app in the simulator.

---

## **Technologies Used**
- Swift
- SwiftUI
- Spotify Web API
