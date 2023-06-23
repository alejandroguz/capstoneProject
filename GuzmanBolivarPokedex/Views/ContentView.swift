//
//  ContentView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      OnboardingView()
        .tabItem {
          Label("Intro", systemImage: "info.square.fill")
            .foregroundColor(.white)
        }

      PokeList()
        .tabItem {
          Label("List", systemImage: "list.bullet.rectangle.portrait")
        }

      ProfileView()
        .tabItem {
          Label("Profile", systemImage: "person.text.rectangle")
        }
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    ContentView()
      .previewInterfaceOrientation(.landscapeRight)
  }
}
