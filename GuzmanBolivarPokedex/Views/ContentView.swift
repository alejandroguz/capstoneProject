//
//  ContentView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import SwiftUI

struct ContentView: View {
  @State var selection: PokeButton = PokeTabItem.list.iconName

  var body: some View {
    CustomTabBarContainerView(selection: $selection) {
      PokeList()
        .pokeTabItem(tab: PokeTabItem.list.iconName, selection: $selection)
      ProfileView()
        .pokeTabItem(tab: PokeTabItem.profile.iconName, selection: $selection)
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
