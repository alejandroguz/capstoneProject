//
//  PokemonProfile_Networking.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/23/23.
//

import Foundation
import SwiftUI

class ProfileViewNetworking: ObservableObject {
  @Published var artwork = [UIImage]()
  @Published var savedArtwork = [UIImage]()
  @Published var pokemonsSavedMessage = "There are no Pokemons saved."
  @Published var color = Color.red

  enum NetworkError: Error {
    case decodingError
    case failHttpRequest(message: String)
    case retrieveDataError
    case errorSavingData(message: String)
    case errorReadingData(message: String)
  }

  func handleError(_ error: NetworkError) {
    switch error {
    case .failHttpRequest(let message):
      print("HTTP Request error: \(message)")
    case .decodingError:
      print("Decoding error.")
    case .retrieveDataError:
      print("Unknown error. Couldn't get data.")
    case .errorSavingData(let message):
      print("There was an error saving the data: \(message)")
    case .errorReadingData(let message):
      print("There was an error reading the data from File :\(message)")
    }
  }

  func getArtworkRequestURL(forPokemonNumber: Int) -> String {
    let baseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/"
    guard var urlComponents = URLComponents(string: baseURL) else { return "failed" }
    urlComponents.queryItems = [
      URLQueryItem(name: "official-artwork/", value: nil),
      URLQueryItem(name: String(forPokemonNumber), value: nil),
      URLQueryItem(name: ".png", value: nil)
    ]
    let newURL = urlComponents.url!.absoluteString
      .replacingOccurrences(of: "?", with: "")
      .replacingOccurrences(of: "&", with: "")
    return newURL
  }

  func savePokemon() {
    var number = 1
    let fileManager = FileManager.default
    let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first

    if let fileURL = path?.appending(path: "pokemon") {
      print("FileURL: \(fileURL)")
    } else { return }

    for pokemon in artwork {
      guard let fileURL = path?.appending(path: "pokemon\(number)") else { return }
      do {
        guard let data = pokemon.pngData() else { return }
        try data.write(to: fileURL)
        print("Success saving data!")
        number += 1
        pokemonsSavedMessage = "Pokemons were saved!"
        color = Color.green
      } catch {
        handleError(.errorSavingData(message: error.localizedDescription))
      }
    }
  }

  func getPokemonFromFile() {
    let fileManager = FileManager.default
    let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    for number in 1...6 {
      guard let url = path else { return }
      let pokemonPath = url.appending(path: "pokemon\(number)")
      do {
        let data = try Data(contentsOf: pokemonPath)
        if let img = UIImage(data: data) {
          savedArtwork.append(img)
        } else { return }
      } catch {
        handleError(.errorReadingData(message: error.localizedDescription))
        return
      }
    }
  }

  func fetchPokemonArtwork() async throws -> UIImage? {
    let urlSessionConfig = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: urlSessionConfig)

    Task { @MainActor in
      artwork = []
    }

    for _ in 1...6 {
      let randomNumber = Int.random(in: 1...151)
      let stringURL = getArtworkRequestURL(forPokemonNumber: randomNumber)
      print("\(stringURL)")
      guard let artworkURL = URL(string: stringURL) else { return nil }
      let urlRequest = URLRequest(url: artworkURL, cachePolicy: .returnCacheDataElseLoad)

      do {
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)

        guard let response = urlResponse as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
          handleError(.failHttpRequest(message: "A response error has occurred: fetchPokemonArtwork"))
          return nil
        }

        Task { @MainActor in
          if let img = UIImage(data: data) {
            artwork.append(img)
          } else { return }
        }
      } catch { return nil }
    }

    return nil
  }
}
