//
//  GuzmanBolivarPokedexTests.swift
//  GuzmanBolivarPokedexTests
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import XCTest
import SwiftUI
@testable import GuzmanBolivarPokedex

final class GuzmanBolivarPokedexTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_Networking_getRequestURL_ShouldGetAnURLForFetching() {
    // Given
    let network = Networking()
    let expectedURL = "https://pokeapi.co/api/v2/pokemon/25"

    // When
    let pokemonURL = network.getRequestURL(forPokemonNumber: 25)

    // Then
    XCTAssertEqual(expectedURL, pokemonURL)
  }

  func test_Networking_getPokemonProfile_ShouldGetPokedexFromAPICall() async throws {
    // Given
    let network = Networking()

    // When
    let result = try? await network.getPokemonProfile()

    // Then
    XCTAssertNotNil(result)
  }

  func test_Networking_getPokemonImg_ShouldGetPokemonImg() async throws {
    // Given
    let network = Networking()
    var img: [UIImage]?

    // When
    if let pokedexArray = try? await network.getPokemonProfile() {
      img = try? await network.getPokemonImg(pokemon: pokedexArray)
    }

    // Then
    XCTAssertNotNil(img)
  }

  func test_PokemonEncounterNetworking_getPokemonEncounterInfo_GetPokemonDetailInfo() async throws {
    // Given
    let pokemonEncounterNetworking = PokemonEncounterNetworking()
    let url = "https://pokeapi.co/api/v2/pokemon/6/encounters"

    // When
    let result = try? await pokemonEncounterNetworking.getPokemonEncounterInfo(url: url)
    // Then
    XCTAssertNotNil(result)
    XCTAssertNoThrow(result)
  }
}
