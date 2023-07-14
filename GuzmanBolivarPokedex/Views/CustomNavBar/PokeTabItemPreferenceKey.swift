//
//  PokeTabItemPreferenceKEy.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 7/13/23.
//

import Foundation
import SwiftUI

struct PokeTabItemPreferenceKey: PreferenceKey {
  static var defaultValue: [PokeButton] = []

  static func reduce(value: inout [PokeButton], nextValue: () -> [PokeButton]) {
    value.append(contentsOf: nextValue())
  }
}

struct PokeTabItemViewModifier: ViewModifier {
  let tab: PokeButton
  @Binding var selection: PokeButton

  func body(content: Content) -> some View {
    content
      .opacity(selection == tab ? 1.0 : 0.0)
      .preference(key: PokeTabItemPreferenceKey.self, value: [tab])
  }
}

extension View {
  func pokeTabItem(tab: PokeButton, selection: Binding<PokeButton>) -> some View {
    self.modifier(PokeTabItemViewModifier(tab: tab, selection: selection))
  }
}
