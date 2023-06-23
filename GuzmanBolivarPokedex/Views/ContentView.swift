//
//  ContentView.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = ContentViewVM().network

  let columns = [GridItem(.flexible(minimum: 180, maximum: 210)),
                 GridItem(.flexible(minimum: 180, maximum: 210))]

  var body: some View {
    VStack {
      if !viewModel.pokemonProfile.isEmpty,
         !viewModel.pokeIMG.isEmpty {
        NavigationStack {
          ScrollView {
            LazyVGrid(columns: columns) {
              ForEach(Array(viewModel.pokemonProfile.enumerated()), id: \.1.name) { itemIndex, item in

                NavigationLink {
                  PokeDetails(pokedex: item, sprites: item.sprites)
                } label: {
                  PokemonGrid(img: viewModel.pokeIMG[itemIndex],
                              name: item.name,
                              height: item.height,
                              weight: item.weight)
                }
              }
            }
            Button {
              if (viewModel.page + 1) <= viewModel.totalPages {
                viewModel.loadMoreContent(
                  start: viewModel.start,
                  ending: viewModel.end
                )
              }
            } label: {
              if (viewModel.page + 1) <= viewModel.totalPages {
                Text("Load more")
              } else {
                Text("No more")
              }
            }

          }
          .navigationTitle("Catch them all!")
          .padding()
        }
      } else {
        ProgressView()
        Text("Loading...")
      }
    }
  }
}

struct PokeDetails: View {
  var pokemonEncounterVM = PokemonEncounterVM().network
  var pokedex: Pokedex?
  var sprites: Sprites?
  @State var encounters: String?
  @State var chance: Int?
  @State var maxLevel: Int?
  @State var minLevel: Int?
  @State var arrayOfPics: [UIImage]?

  var body: some View {
    VStack {
      HStack {
        if arrayOfPics != nil {
          if let array = arrayOfPics {
            ForEach(array, id: \.cgImage) { img in
              Image(uiImage: img)
            }
          }
        } else {
          VStack {
            ProgressView()
            Text("Loading Data....")
              .font(.subheadline)
          }
        }

      }

      List {
        Section("Pokemon Data") {
          Text("Base Experience: \(pokedex?.baseExperience ?? 1)")
          Text("Height: \(pokedex?.height ?? 1)")
          Text(encounters ?? "No location")
          Text("Maximum Chance of Encounter: \(chance ?? 0)")
          Text("Max Level: \(maxLevel ?? 0)")
          Text("Min Level: \(minLevel ?? 0)")
        }
      }
    }
    .navigationTitle(Text("\(pokedex?.name.uppercased() ?? "")"))
    .onAppear {
      Task { @MainActor in
        if let data = try? await pokemonEncounterVM.getPokemonEncounterInfo(
          url: pokedex?.locationAreaEncounters ?? ""
        ) {
          encounters = data.first?.locationArea.name
          chance = data.first?.versionDetails.first?.encounterDetails.first?.chance
          minLevel = data.first?.versionDetails.first?.encounterDetails.first?.minLevel
          maxLevel = data.first?.versionDetails.first?.encounterDetails.first?.maxLevel
        }
        if let pokePictures = sprites {
          arrayOfPics = try? await pokemonEncounterVM.getPokemonImages(url: pokePictures)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    PokeDetails()
    ContentView()
    ContentView()
      .previewInterfaceOrientation(.landscapeRight)
  }
}
