//
//  PokemonGrid.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/20/23.
//

import SwiftUI

struct PokemonGrid: View {
  var img: UIImage
  var name: String
  var height: Int
  var weight: Int
  var body: some View {
    HStack {
      Image(uiImage: img)
        .resizable()
        .frame(width: 80, height: 80)

      Spacer()
        .frame(width: 5)

      VStack(alignment: .leading) {
        Text("\(name.capitalized)")
          .font(.subheadline)
        Text("Height: \(height)")
          .font(.caption)
        Text("Weight: \(weight)")
          .font(.caption)
      }

      Spacer()
    }
    .frame(idealWidth: .infinity)
    .background(
      Rectangle()
        .fill(Color.yellow.opacity(0.2))
    )
    .cornerRadius(10)
  }
}
