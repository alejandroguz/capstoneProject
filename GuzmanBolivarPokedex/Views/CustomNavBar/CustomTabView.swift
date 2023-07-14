//
//  CustomNavBar.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 7/11/23.
//

import SwiftUI

struct PokeButton: View, Equatable {
  var button: TabButton
  var body: some View {
    Text(button.id)
    .anchorPreference(key: TabButtonPreferenceKey.self,
                      value: .bounds,
                      transform: { [TabButtonPreference(button: button, anchor: $0)] })
  }
}

struct CustomTabView: View {
  @Binding var selection: PokeButton
  var tabArray: [PokeButton]

  var body: some View {
    VStack(spacing: 5) {
      HStack(spacing: 30) {
        ForEach(tabArray, id: \.button.id) { array in
          array
            .onTapGesture {
              withAnimation {
                selection = array
              }
              print("This is the array: \(array)")
            }
        }
      }
      .frame(height: 40)
      .frame(maxWidth: .infinity)
      .background(Color.green.edgesIgnoringSafeArea(.bottom))
    }
    .overlayPreferenceValue(TabButtonPreferenceKey.self) { preferences in
      GeometryReader { proxy in
        if let selected = preferences.first(where: { $0.button == selection.button }) {
          let frame = proxy[selected.anchor]
          NavPokeBall()
            .position(x: frame.midX, y: frame.maxY + 12)
        }
      }
    }
  }
}

struct CustomNavBar_Previews: PreviewProvider {
  static let tabs = [
    PokeButton(button: TabButton(id: "Pepito")),
    PokeButton(button: TabButton(id: "Jose")),
    PokeButton(button: TabButton(id: "Miguel"))
  ]

  static var previews: some View {
    VStack {
      Spacer()
      CustomTabView(selection: .constant(tabs[0]), tabArray: tabs)
    }
  }
}

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
