//
//  GuzmanBolivarPokedexApp.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import SwiftUI

@main
struct GuzmanBolivarPokedexApp: App {
  @StateObject var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(networkMonitor)
        }
    }
}
