//
//  PokemonDetails.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/20/23.
//

import SwiftUI

struct PokemonDetails: View {
  @State var pokedex: Pokedex

  var body: some View {
    Text("Hello, World!:\(pokedex.name)")
  }
}
