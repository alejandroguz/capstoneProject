//
//  PokemonDetails.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/20/23.
//

import SwiftUI

struct PokeDetails: View {
  @EnvironmentObject var networkMonitor: NetworkMonitor
  var pokemonEncounterVM = PokemonEncounterVM().network
  var pokedex: Pokedex?
  var sprites: Sprites?
  @State var encounters: String?
  @State var chance: Int?
  @State var maxLevel: Int?
  @State var minLevel: Int?
  @State var arrayOfPics: [UIImage]?

  var body: some View {
    if networkMonitor.isConnected {
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
    } else {
      NoNetworkView()
    }
  }
}
