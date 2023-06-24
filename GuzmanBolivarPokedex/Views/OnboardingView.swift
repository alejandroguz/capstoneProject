//
//  OnboardingView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/22/23.
//

import SwiftUI

struct OnboardingView: View {
  @State private var isAnimated = false
  var body: some View {
    ZStack {
      Color("appColor").ignoresSafeArea()
      ScrollView {
        VStack {
          Image(systemName: "ticket.fill")
            .font(.largeTitle)
            .foregroundColor(.white)
          Text("PokeApp")
            .font(.largeTitle)
          VStack(alignment: .leading) {
            Text("Welcome to the Pokemon App")
              .font(.headline)
              .padding(.bottom)
              .padding(.top)
            Text("The purpose of this app is to give you the closes experience to a real Pokedex.")
            Text("- It allows you to see a list of the first 151 pokemons from the first pokemon generation.")
              .padding(.top, 5)
            Text("- Check the some details about each pokemon.")
              .padding(.top, 5)
            Text("- Visualize a Pokemon Team. (In the future you will be able to create your own profile.)")
            Text("You can save your Pokemons, but you will need to open and close the app to see your saved pokemons.")
              .padding(.top, 5)
          }
          .multilineTextAlignment(.leading)
          .foregroundColor(.white)
          .frame(minWidth: 300, idealWidth: 300, maxWidth: 400)
          .background(
            Rectangle()
              .fill(
                Color("appColor")
              )
          )
          .padding(.horizontal)

          VStack {
            Text("Look at some of the tabs below 👇😌")
              .font(.headline)
              .bold()
          }
          .frame(width: 200, height: 80)
          .background(Color.cyan)
          .scaleEffect( isAnimated ? 0.9: 0.8) // <3>
          .animation(Animation.linear(duration: 1).repeatForever(), value: isAnimated)
          .onAppear {
            isAnimated = true
          }
        }
      }
    }
  }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
    OnboardingView()
      .previewInterfaceOrientation(.landscapeRight)
  }
}
