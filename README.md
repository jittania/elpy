# Elpy

One of Spotify's primary advantages is that it provides a central hub for musical collections across devices. It streamlines the process of actually getting music, organizing it, and storing it on multiple devices. This means users can devote more time to actually organizing and maintaining playlists. However, because of Spotify's limited search specifity, users can find themselves reliant on outside sources to find new music based on criteria like genre, release date, or charateristics of the song (BPM, energy level, instrumental nature). 

What if there was a way to search directly in Spotify's database for songs based on specific search critera, the same way you might look for new LPs in a record store? 

Elpy expands a Spotify user's ability to perform informed searches for new music, while learning about the music they discover. This iOS app is intended to augment and diversify the musical discovery experience provided by Spotify without compromising its advantage as a multi-device hub for your musical library.

## Technologies 
- Swift
- SwiftUI
- Spotify Web API

## MVP Feature Set

1. User can employ Elpy to find new music and expand their existing Spotify library: user has full access to their personal Spotify library from within app: can create, modify, play playlists from app
2. User has option to build an "informed" crate vs. letting Elpy build a crate. To build an "Informed" crate, user selects (has option to skip any, but must respond to at least one) :
   - Release date period 
   - Genre (a complete list that responds to a "filter" input field that user can employ to narrow down genres)
   - Miscellaneous style criteria: Valence, Danceability, Obscurity, Instrumentalness, Acousticness, Energy, BPM
3. To let Elpy build a crate, user has option to choose style specifications, or let Elpy choose 20 songs at random 
4. User is given a "crate" of songs (a Spotify playlist of 20 songs) based on their search choices
   - Songs are displayed in format of Track name : Artist: Release Year : Genre 
   - User can play songs within the app, favorite individual songs, add songs to existing playlists, or save the entire Elpy crate as a playlist