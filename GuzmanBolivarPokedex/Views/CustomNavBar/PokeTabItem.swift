//
//  PokeTabItem.swift
//  GuzmanBolivarPokedex
//
//  Created by Alejandro Guzman Bolivar on 7/13/23.
//

import Foundation
import SwiftUI

enum PokeTabItem: Hashable {
  case home, list, profile

  var iconName: PokeButton {
    switch self {
    case .home:
      return PokeButton(button: TabButton(id: "Home"))
    case .list:
      return PokeButton(button: TabButton(id: "List"))
    case .profile:
      return PokeButton(button: TabButton(id: "Profile"))
    }
  }
}
