//
//  ProfileView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/22/23.
//

import SwiftUI

struct ProfileView: View {
  @StateObject var viewModel = ProfileViewVM().network

  let columns = [GridItem(.flexible(minimum: 180, maximum: 260)),
                 GridItem(.flexible(minimum: 180, maximum: 260))]

  var body: some View {
    VStack {
      if !viewModel.artwork.isEmpty {
        Text("Everything worth pursuing takes time and effort like Bulbasaur.")
          .foregroundColor(.white)
          .font(.headline)
          .padding()
          .background(
            Rectangle()
              .fill(Color.blue)
          )
          .cornerRadius(20)
          .padding(.top, 10)

        HStack {
          Button {
            viewModel.savePokemon()
          } label: {
            Image(systemName: "arrow.right.square")
            Text("Save Pokemons!")
          }

          Button {
            Task { @MainActor in
              try? await viewModel.fetchPokemonArtwork()
            }
          } label: {
            Image(systemName: "dice")
            Text("Reroll Pokemons!")
          }

        }

        ScrollView {
          LazyVGrid(columns: columns) {
            ForEach(viewModel.artwork, id: \.self) { item in
              Image(uiImage: item)
                .resizable()
                .frame(minWidth: 120,
                       idealWidth: 120,
                       maxWidth: 120,
                       minHeight: 120,
                       idealHeight: 120,
                       maxHeight: 120)
            }
          }

          // Retrieved save pokemon data
          if viewModel.savedArtwork.isEmpty {
            Text(viewModel.pokemonsSavedMessage)
              .foregroundColor(.white)
              .font(.headline)
              .padding()
              .background(
                Rectangle()
                  .fill(viewModel.color)
              )
              .cornerRadius(20)
              .padding(.top, 10)
          } else {
            Text("Here are your saved Pokemons!")
              .foregroundColor(.white)
              .font(.headline)
              .padding()
              .background(
                Rectangle()
                  .fill(Color.blue)
              )
              .cornerRadius(20)
              .padding(.top, 10)

            LazyVGrid(columns: columns) {
              ForEach(viewModel.savedArtwork, id: \.cgImage) { item in
                Image(uiImage: item)
                  .resizable()
                  .frame(minWidth: 120,
                         idealWidth: 120,
                         maxWidth: 120,
                         minHeight: 120,
                         idealHeight: 120,
                         maxHeight: 120)
              }
            }
          }
        }
      } else {
        ProgressView()
        Text("Loading....")
      }
    }
    .onAppear {
      if viewModel.artwork.isEmpty {
        Task { @MainActor in
          try? await viewModel.fetchPokemonArtwork()
        }
      }
      viewModel.getPokemonFromFile()
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
