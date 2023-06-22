//
//  Networking.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import Foundation
import SwiftUI

class Networking: ObservableObject {
  @Published var pokemonProfile = [Pokedex]()
  @Published var pokeIMG = [UIImage]()
  var totalPages = 6
  var page = 1

  init() {
    Task { @MainActor in
      guard let data = try? await getPokemonProfile() else { return }
      pokemonProfile = data
      guard let arrayOfImages = try? await getPokemonImg(pokemon: data) else { return }
      pokeIMG = arrayOfImages
    }
  }


  func loadMoreContent(currentItem item: Int) {
    let thresHoldIndex = self.pokemonProfile.index(self.pokemonProfile.endIndex, offsetBy: -1)
    print("This is the thresholdIndex: \(thresHoldIndex)")
    print("This is the item Index: \(item)")
    if thresHoldIndex == item, (page + 1) <= totalPages {
      Task { @MainActor in
//        try? await self.getPokemonProfile(begin: 11, end: 12)
      }
    }
  }

  func loadMoreContent() {
    Task { @MainActor in
      try? await self.getPokemonProfile(start: 11, end: 21)
    }
  }

  func getRequestURL(forPokemonNumber: Int) -> String {
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    guard var urlComponents = URLComponents(string: baseURL) else { return "failed" }
    urlComponents.queryItems = [
      URLQueryItem(name: String(forPokemonNumber), value: nil)
    ]
    let newURL = urlComponents.url!.absoluteString.replacingOccurrences(of: "?", with: "")
    return newURL
  }

  func getPokemonProfile() async throws -> [Pokedex]? {
    let urlSessionConfig = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: urlSessionConfig)
    let decoder = JSONDecoder()

    for pokemonNumber in 1...10 {
      guard let pokemonURL = URL(string: getRequestURL(forPokemonNumber: pokemonNumber)) else { return [] }
      print("This is the url Request string: \(pokemonURL.absoluteString)")

      let urlRequest = URLRequest(url: pokemonURL, cachePolicy: .returnCacheDataElseLoad)

      do {
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)

        guard let response = urlResponse as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
          print("Failed HTTP Request")
          return []
        }

        guard let decodedData = try? decoder.decode(Pokedex.self, from: data) else {
          print("Couldn't decode the data")
          continue
        }
        print("Data decoding successful")
        Task { @MainActor in
          pokemonProfile.append(decodedData)
        }
      } catch {
        print("Failed to retrieve data: \(error.localizedDescription)")
        return []
      }
    }

    if !pokemonProfile.isEmpty {
      print("Success")
      return pokemonProfile
    } else {
      print("The pokemon profile is nil")
      return nil
    }
  }

  func getPokemonProfile(start: Int, end: Int) async throws {
    let urlSessionConfig = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: urlSessionConfig)
    let decoder = JSONDecoder()

    for pokemonNumber in start...end {
      guard let pokemonURL = URL(string: getRequestURL(forPokemonNumber: pokemonNumber)) else { return }

      let urlRequest = URLRequest(url: pokemonURL, cachePolicy: .returnCacheDataElseLoad)

      do {
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)

        guard let response = urlResponse as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
          print("Failed HTTP Request")
          return
        }

        guard let decodedData = try? decoder.decode(Pokedex.self, from: data) else {
          print("Couldn't decode the data")
          continue
        }

        Task { @MainActor in
          try? await self.getPokemonImg(pokemon: decodedData)
          pokemonProfile.append(decodedData)
        }

      } catch {
        print("Failed to retrieve data: \(error.localizedDescription)")
        return
      }
    }
  }

  func getPokemonImg(pokemon: [Pokedex]) async throws -> [UIImage]? {
    let urlSessionConfig = URLSessionConfiguration.default
    urlSessionConfig.requestCachePolicy = .returnCacheDataElseLoad
    let urlSession = URLSession(configuration: urlSessionConfig)
    var pokemonIMG = [UIImage]()

    for poke in pokemon {
      print("This is the image url: \(poke.sprites.frontDefault)")
      if let pokemonIMGURL = URL(string: poke.sprites.frontDefault) {
        let urlRequest = URLRequest(url: pokemonIMGURL, cachePolicy: .returnCacheDataElseLoad)

          do {
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)

            guard let response = urlResponse as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
              print("Failed HTTP Request")
              return nil
            }

            if let image = UIImage(data: data) {
              pokemonIMG.append(image)
            }

          } catch {
            print("Error downloading the image...")
          }
      }
    }

    return pokemonIMG
  }

  func getPokemonImg(pokemon: Pokedex) async throws {
    let urlSessionConfig = URLSessionConfiguration.default
    urlSessionConfig.requestCachePolicy = .returnCacheDataElseLoad
    let urlSession = URLSession(configuration: urlSessionConfig)

    if let pokemonIMGURL = URL(string: pokemon.sprites.frontDefault) {
      let urlRequest = URLRequest(url: pokemonIMGURL, cachePolicy: .returnCacheDataElseLoad)

      do {
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)

        guard let response = urlResponse as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
          print("Failed HTTP Request")
          return
        }

        if let image = UIImage(data: data) {
          Task { @MainActor in
            self.pokeIMG.append(image)
          }
        }

      } catch {
        print("Error downloading the image...")
      }
    }
  }
}
