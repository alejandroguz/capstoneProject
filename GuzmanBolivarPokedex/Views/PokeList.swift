//
//  PokeList.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/22/23.
//

import SwiftUI

struct PokeList: View {
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

struct PokeList_Previews: PreviewProvider {
    static var previews: some View {
        PokeList()
    }
}