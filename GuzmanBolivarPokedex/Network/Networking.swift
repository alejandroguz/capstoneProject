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
  var start = 11
  var end = 20

  enum NetworkError: Error {
    case decodingError
    case failHttpRequest(message: String)
    case retrieveDataError
  }

  func handleError(_ error: NetworkError) {
    switch error {
    case .failHttpRequest(let message):
      print("HTTP Request error: \(message)")
    case .decodingError:
      print("Decoding error.")
    case .retrieveDataError:
      print("Unknown error. Couldn't get data.")
    }
  }

  init() {
    Task { @MainActor in
      guard let data = try? await getPokemonProfile() else { return }
      pokemonProfile = data
      guard let arrayOfImages = try? await getPokemonImg(pokemon: data) else { return }
      pokeIMG = arrayOfImages
    }
  }

//  func loadMoreContent(currentItem item: Int) {
//    let thresHoldIndex = self.pokemonProfile.index(self.pokemonProfile.endIndex, offsetBy: -1)
//    print("This is the thresholdIndex: \(thresHoldIndex)")
//    print("This is the item Index: \(item)")
//    if thresHoldIndex == item, (page + 1) <= totalPages {
//      Task { @MainActor in
//        try? await self.getPokemonProfile(begin: 11, end: 12)
//      }
//    }
//  }

  func loadMoreContent(start with: Int, ending last: Int) {
    Task { @MainActor in
      try? await self.getPokemonImg(start: with, end: last)
      try? await self.getPokemonProfile(start: with, end: last)
    }
    self.page += 1
    self.start += 11
    self.end += 22
  }

  // URLs FOR REQUESTS

  func getRequestURL(forPokemonNumber: Int) -> String {
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    guard var urlComponents = URLComponents(string: baseURL) else { return "failed" }
    urlComponents.queryItems = [
      URLQueryItem(name: String(forPokemonNumber), value: nil)
    ]
    let newURL = urlComponents.url!.absoluteString.replacingOccurrences(of: "?", with: "")
    return newURL
  }

  func getImgRequestURL(forPokemonNumber: Int) -> String {
    let baseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    guard var urlComponents = URLComponents(string: baseURL) else { return "failed" }
    urlComponents.queryItems = [
      URLQueryItem(name: String(forPokemonNumber) + ".png", value: nil)
    ]
    let newURL = urlComponents.url!.absoluteString.replacingOccurrences(of: "?", with: "")
    return newURL
  }

 // INIT FUNCTIONS

  func getPokemonProfile() async throws -> [Pokedex]? {
    let urlSessionConfig = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: urlSessionConfig)
    let decoder = JSONDecoder()

    for pokemonNumber in 1...10 {
      guard let pokemonURL = URL(string: getRequestURL(forPokemonNumber: pokemonNumber)) else { return [] }

      let urlRequest = URLRequest(url: pokemonURL, cachePolicy: .returnCacheDataElseLoad)

      do {
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)

        guard let response = urlResponse as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
          handleError(.failHttpRequest(message: "A response error has occurred: getPokemonProfile"))
          return []
        }

        guard let decodedData = try? decoder.decode(Pokedex.self, from: data) else {
          handleError(.decodingError)
          continue
        }

        Task { @MainActor in
          pokemonProfile.append(decodedData)
        }
      } catch { return nil }
    }

    if !pokemonProfile.isEmpty {
      return pokemonProfile
    } else {
      handleError(.retrieveDataError)
      return nil
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
              handleError(.failHttpRequest(message: "A response error has occurred: getPokemonImg"))
              return nil
            }

            if let image = UIImage(data: data) {
              pokemonIMG.append(image)
            }

          } catch {
            handleError(.retrieveDataError)
            return nil
          }
      }
    }

    return pokemonIMG
  }

  // PAGINATION API FUNCTIONS

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
          handleError(.failHttpRequest(message: "A response error has occurred: getPokemonProfile"))
          return
        }

        guard let decodedData = try? decoder.decode(Pokedex.self, from: data) else {
          handleError(.decodingError)
          continue
        }

        Task { @MainActor in
          pokemonProfile.append(decodedData)
        }

      } catch {
        handleError(.retrieveDataError)
        return
      }
    }
  }

  func getPokemonImg(start: Int, end: Int) async throws {
    let urlSessionConfig = URLSessionConfiguration.default
    urlSessionConfig.requestCachePolicy = .returnCacheDataElseLoad
    let urlSession = URLSession(configuration: urlSessionConfig)

    for number in start...end {
      if let pokemonIMGURL = URL(string: getImgRequestURL(forPokemonNumber: number)) {
        let urlRequest = URLRequest(url: pokemonIMGURL, cachePolicy: .returnCacheDataElseLoad)

        do {
          let (data, urlResponse) = try await urlSession.data(for: urlRequest)

          guard let response = urlResponse as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
            handleError(.failHttpRequest(message: "A response error has occurred: getPokemonImg"))
            return
          }

          if let image = UIImage(data: data) {
            Task { @MainActor in
              self.pokeIMG.append(image)
            }
          }

        } catch {
          handleError(.retrieveDataError)
        }
      }
    }
  }
}
