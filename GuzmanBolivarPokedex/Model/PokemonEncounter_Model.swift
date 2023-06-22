// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonEncounter = try? JSONDecoder().decode(PokemonEncounter.self, from: jsonData)

import Foundation

// MARK: - PokemonEncounterElement
struct PokemonEncounterElement: Codable {
    let locationArea: LocationArea
    let versionDetails: [VersionDetail]

    enum CodingKeys: String, CodingKey {
        case locationArea = "location_area"
        case versionDetails = "version_details"
    }
}

// MARK: - LocationArea
struct LocationArea: Codable {
    let name: String
    let url: String
}

// MARK: - VersionDetail
struct VersionDetail: Codable {
    let encounterDetails: [EncounterDetail]
    let maxChance: Int
    let version: LocationArea

    enum CodingKeys: String, CodingKey {
        case encounterDetails = "encounter_details"
        case maxChance = "max_chance"
        case version
    }
}

// MARK: - EncounterDetail
struct EncounterDetail: Codable {
    let chance: Int
    let conditionValues: [LocationArea]
    let maxLevel: Int
    let method: LocationArea
    let minLevel: Int

    enum CodingKeys: String, CodingKey {
        case chance
        case conditionValues = "condition_values"
        case maxLevel = "max_level"
        case method
        case minLevel = "min_level"
    }
}

typealias PokemonEncounter = [PokemonEncounterElement]
