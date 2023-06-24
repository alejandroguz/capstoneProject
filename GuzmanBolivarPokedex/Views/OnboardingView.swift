//
//  OnboardingView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/22/23.
//

import SwiftUI

struct OnboardingView: View {
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
            Text("- It allows you to see a list of the first 150 pokemons from the first pokemon generation.")
              .padding(.top, 5)
            Text("- Check the some details about each pokemon.")
              .padding(.top, 5)
            Text("- Visualize a Pokemon Trainer Profile. (In the future you will be able to create your own profile.)")
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
