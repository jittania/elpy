//
//  elpyApp.swift
//  elpy
//
//  Created by Jittania Smith on 7/27/21.
//

import SwiftUI

@main
struct elpyApp: App {
    
    @StateObject var spotify = Spotify()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(spotify)
        }
    }
}
