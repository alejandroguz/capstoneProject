//
//  CustomTabView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 7/11/23.
//

import Foundation
import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
  let content: Content
  @State private var tabs: [PokeButton] = []
  @Binding var selection: PokeButton

  init(selection: Binding<PokeButton>, @ViewBuilder content: () -> Content) {
    self._selection = selection
    self.content = content()
  }

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        content
      }
      Spacer()
      CustomTabView(selection: $selection, tabArray: tabs)
    }
    .onPreferenceChange(PokeTabItemPreferenceKey.self) { item in
      self.tabs = item
    }
  }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
  static let tabs = [
    PokeButton(button: TabButton(id: "Pepito")),
    PokeButton(button: TabButton(id: "Jose")),
    PokeButton(button: TabButton(id: "Miguel"))
  ]

  static var previews: some View {
    CustomTabBarContainerView(selection: .constant(tabs[1])) {
      Color.red
    }
  }
}
