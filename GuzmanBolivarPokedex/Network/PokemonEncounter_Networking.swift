//
//  PokemonEncounter_Networking.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 6/21/23.
//

import Foundation
import UIKit

class PokemonEncounterNetworking: ObservableObject {
  

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
        print("Failed HTTP Request")
        return nil
      }

      print("\(response.statusCode)")

      guard let decodedData = try? decoder.decode(PokemonEncounter.self, from: data) else {
        print("Couldn't decode the PokemonEncounter Data")
        return nil
      }

      return decodedData

    } catch {
      print("Failed the get data request")
      return nil
    }
  }

  func getPokemonImages(url: Sprites) async throws -> [UIImage]? {
    let urlSessionConfig = URLSessionConfiguration.default
    let urlSession = URLSession(configuration: urlSessionConfig)
    let decoder = JSONDecoder()
    var arrayOfPictures = [UIImage]()

    var arrayOfUrls =
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
          print("Failed HTTP Request")
          return nil
        }

        print("Pokemon img status code:\(response.statusCode)")

        if let img = UIImage(data: data) {
          arrayOfPictures.append(img)
        }

      } catch {
        print("Failing with decodeing Pictures")
        return nil
      }
    }

    return arrayOfPictures
  }
}
