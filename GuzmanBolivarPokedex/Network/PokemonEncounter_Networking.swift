//
//  PokemonEncounter_Networking.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/21/23.
//

import Foundation
import UIKit

class PokemonEncounterNetworking: ObservableObject {

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

  func getPokemonEncounterInfo(url: String) async throws -> PokemonEncounter? {
    let urlSessionConfig = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: urlSessionConfig)
    let decoder = JSONDecoder()

    guard let convertedURL = URL(string: url) else { return nil }

    let urlRequest = URLRequest(url: convertedURL)

    do {
      let (data, urlResponse) = try await urlSession.data(for: urlRequest)

      guard let response = urlResponse as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
        handleError(.failHttpRequest(message: "A response error has occurred: getPokemonEncounterInfo"))
        return nil
      }

      print("\(response.statusCode)")

      guard let decodedData = try? decoder.decode(PokemonEncounter.self, from: data) else {
        handleError(.decodingError)
        return nil
      }

      return decodedData

    } catch {
      handleError(.retrieveDataError)
      return nil
    }
  }

  func getPokemonImages(url: Sprites) async throws -> [UIImage]? {
    let urlSessionConfig = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: urlSessionConfig)
    var arrayOfPictures = [UIImage]()

    let arrayOfUrls =
    [
      url.backDefault,
      url.frontDefault,
      url.backShiny,
      url.frontShiny
    ]

    for pictureURL in arrayOfUrls {
      guard let url = URL(string: pictureURL) else { return nil }
      let urlRequest = URLRequest(url: url)

      do {
        let (data, urlResponse) = try await urlSession.data(for: urlRequest)

        guard let response = urlResponse as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
          handleError(.failHttpRequest(message: "A response error has occurred: getPokemonImages"))
          return nil
        }

        if let img = UIImage(data: data) {
          arrayOfPictures.append(img)
        }

      } catch {
        handleError(.retrieveDataError)
        return nil
      }
    }

    return arrayOfPictures
  }
}
