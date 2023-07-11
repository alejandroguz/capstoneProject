//
//  CustomNavBar.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 7/11/23.
//

import SwiftUI

struct TabButton: Identifiable, Equatable {
  var id: String
}

struct TabButtonPreference: Equatable {
  let button: TabButton
  let anchor: Anchor<CGRect>
}

struct TabButtonPreferenceKey: PreferenceKey {
  static var defaultValue = [TabButtonPreference]()

  static func reduce(value: inout [TabButtonPreference], nextValue: () -> [TabButtonPreference]) {
    value.append(contentsOf: nextValue())
  }
}

struct SelectedButton: View {
  var button: TabButton
  @Binding var selection: TabButton?
  var body: some View {
    Button {
      withAnimation {
        selection = button
      }
    } label: {
      Text(button.id)
    }
    .buttonStyle(.plain)
    .anchorPreference(key: TabButtonPreferenceKey.self,
                      value: .bounds,
                      transform: { [TabButtonPreference(button: button, anchor: $0)] })
  }
}

struct CustomNavBar: View {
  @State private var selectedButton: TabButton?

  let buttons = [
    TabButton(id: "Main"),
    TabButton(id: "Your Pokemons"),
    TabButton(id: "New")
  ]

  var body: some View {
    VStack(spacing: 5) {
      HStack(spacing: 30) {
        ForEach(buttons) { button in
          SelectedButton(button: button, selection: $selectedButton)
        }
      }
      .frame(width: 300)
      .background(Color.green)
    }
    .overlayPreferenceValue(TabButtonPreferenceKey.self) { preferences in
      GeometryReader { proxy in
        if let selected = preferences.first(where: { $0.button == selectedButton }) {
          let frame = proxy[selected.anchor]
          NavPokeBall()
            .position(x: frame.midX, y: frame.maxY + 12)
        }
      }
    }
  }
}

struct NavPokeBall: View {
  var body: some View {
    ZStack {
      Circle()
        .fill(.linearGradient(Gradient(colors: [.red, .white]),
                              startPoint: UnitPoint(x: 1.00, y: 0.50),
                              endPoint: UnitPoint(x: 1.00, y: 0.53)))
      Circle()
        .strokeBorder(.black, lineWidth: 2, antialiased: false)

      RoundedRectangle(cornerRadius: 10)
        .frame(width: 16, height: 2)

      Circle()
        .fill(.white)
        .frame(width: 8, height: 8)
      Circle()
        .strokeBorder(.black, lineWidth: 2, antialiased: false)
        .frame(width: 8, height: 8)
    }
    .frame(width: 20, height: 20)
  }
}

struct CustomNavBar_Previews: PreviewProvider {
  static var previews: some View {
    CustomNavBar()
  }
}
