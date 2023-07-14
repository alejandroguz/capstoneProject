//
//  ContentView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import SwiftUI

struct ContentView: View {
  @State var selection: PokeButton = PokeButton(button: TabButton(id: "Pepito"))

  var body: some View {
    CustomTabBarContainerView(selection: $selection) {
      Color.red
        .pokeTabItem(tab: PokeButton(button: TabButton(id: "hehe")), selection: $selection)
      Color.blue
        .pokeTabItem(tab: PokeButton(button: TabButton(id: "soso")), selection: $selection)
      Color.yellow
        .pokeTabItem(tab: PokeButton(button: TabButton(id: "hihi")), selection: $selection)
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

//    TabView {
//      OnboardingView()
//        .tabItem {
//          Label("Intro", systemImage: "info.square.fill")
//            .foregroundColor(.white)
//        }
//
//      PokeList()
//        .tabItem {
//          Label("List", systemImage: "list.bullet.rectangle.portrait")
//        }
//
//      ProfileView()
//        .tabItem {
//          Label("Profile", systemImage: "person.text.rectangle")
//        }
//    }
