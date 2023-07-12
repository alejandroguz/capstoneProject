//
//  SplashScreen.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 7/4/23.
//

import SwiftUI

struct SplashScreen: View {
  @State private var show = true

  func showSplash(after delay: Double) async {
    try? await Task.sleep(for: Duration.seconds(delay))
    withAnimation(.default) {
      show = false
    }
  }

  var body: some View {
    if show {
      PokeBall()
        .frame(width: 300, height: 300)
        .onAppear {
          Task { @MainActor in
            await showSplash(after: 3)
          }
        }
    } else if show == false {
      TabView {
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
}

struct PokeBall: View {
  var body: some View {
    ZStack {
      ZStack {
        Circle()
          .fill(.linearGradient(Gradient(colors: [.red, .white]),
                                startPoint: UnitPoint(x: 1.00, y: 0.50),
                                endPoint: UnitPoint(x: 1.00, y: 0.53)))
        Circle()
          .strokeBorder(Color.black, lineWidth: 15, antialiased: false)
      }
    }
    .pokeballAnimation(degrees: 360.0)
  }
}

struct PokeballAnimationModifier: ViewModifier {
  @State var animating = false
  @State var degree: Double
  @State var color: Color = .white
  @State var scale: Double = 1.0

  func body(content: Content) -> some View {
    content
      .overlay(content: {
        ZStack {
          Rectangle()
            .frame(height: 20)
          Circle()
            .fill(color)
            .frame(width: 100, height: 100)
          Circle()
            .strokeBorder(Color.black, lineWidth: 15, antialiased: false)
            .frame(width: 100, height: 100)
        }
      })
      .rotationEffect(Angle(degrees: animating ? degree : 0))
      .scaleEffect(scale)
      .onAppear(perform: {
        withAnimation(.default.speed(0.20), {
          animating = true
        })
        withAnimation(.easeIn(duration: 1).delay(2)) {
          animating = false
        }
        withAnimation(.easeOut(duration: 1).delay(2.5)) {
          color = .red
          scale = 0.5
        }
        withAnimation(.easeIn.delay(3)) {
          scale = 5
          color = .white
        }
      })
      .transition(.asymmetric(insertion: .scale, removal: .opacity))
  }
}

extension View {
  func pokeballAnimation(degrees: Double) -> some View {
    self.modifier(PokeballAnimationModifier(degree: degrees))
  }
}

struct SplashScreen_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreen()
  }
}
